/// Builds indication marks for PageView from any Widget and/or Animation.
library page_view_indicator_ns;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_view_indicator_ns/src/indicator.dart';

export 'src/circle.dart';

typedef Widget IndicatorBuilder(AnimationController controller, int index);

/// The Indicator Widget, you would likely put it next to your PageView.
class PageViewIndicator extends StatefulWidget {
  /// [pageIndexNotifier] is how we can properly handle page changes.
  /// [length] is how much pages there is in the [PageView].
  /// [normalBuilder] is how we should build the Indicator at its normal state.
  /// [highlightedBuilder] is how we should build the Indicator at its highlighted state.
  /// [currentPage] gives you the ability to star the Indicator at a given index.
  /// [indicatorPadding] space around each Indicator.
  PageViewIndicator({
    Key? key,
    required this.pageIndexNotifier,
    required this.length,
    required this.normalBuilder,
    required this.highlightedBuilder,
    this.currentPage = 0,
    this.indicatorPadding = const EdgeInsets.all(8.0),
    this.alignment = MainAxisAlignment.center,
  }) : super(key: key);

  final ValueNotifier<int> pageIndexNotifier;
  final int length;
  final IndicatorBuilder normalBuilder;
  final IndicatorBuilder highlightedBuilder;
  final int currentPage;
  final EdgeInsets indicatorPadding;
  final MainAxisAlignment alignment;

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator>
    with TickerProviderStateMixin {
  late List<Indicator> _indicators;
  late int _prevPage;

  void _generateIndicators() {
    _indicators.forEach((indicator) => indicator.dispose());
    _indicators = List.generate(
        widget.length,
        (index) => Indicator(
            index: index,
            normalController: AnimationController(
              vsync: this,
              duration: Duration(microseconds: 200),
            )..forward(),
            highlightedController: AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 200),
            )));
  }

  void _indicatorsListener() {
    final currPage = widget.pageIndexNotifier.value;

    if (currPage != _prevPage) {
      _indicators[_prevPage].normalController.forward();
      _indicators[_prevPage].highlightedController.reverse();

      _indicators[currPage].normalController.reverse();
      _indicators[currPage].highlightedController.forward();

      _prevPage = currPage;
    }
  }

  void _addIndicatorsListener() {
    widget.pageIndexNotifier.removeListener(_indicatorsListener);
    widget.pageIndexNotifier.addListener(_indicatorsListener);
  }

  @override
  void initState() {
    super.initState();
    _prevPage = max(0, widget.currentPage);

    _generateIndicators();

    _indicators[widget.currentPage].normalController.reverse();
    _indicators[widget.currentPage].highlightedController.forward();

    _addIndicatorsListener();
  }

  @override
  void didUpdateWidget(PageViewIndicator oldWidget) {
    if (oldWidget.length != widget.length) {
      final currPage = min(widget.pageIndexNotifier.value, widget.length - 1);

      _generateIndicators();

      _indicators[currPage].normalController.reverse();
      _indicators[currPage].highlightedController.forward();

      _prevPage = currPage;
    }

    super.didUpdateWidget(oldWidget);

    _addIndicatorsListener();
  }

  @override
  void dispose() {
    _indicators.forEach((indicator) => indicator.dispose());
    widget.pageIndexNotifier.removeListener(_indicatorsListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.alignment,
      children: _indicators
          .map<Widget>((indicator) => _buildIndicator(indicator))
          .toList(),
    );
  }

  Widget _buildIndicator(Indicator indicator) {
    return Padding(
      padding: widget.indicatorPadding,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          widget.normalBuilder(indicator.normalController, indicator.index),
          widget.highlightedBuilder(
              indicator.highlightedController, indicator.index),
        ],
      ),
    );
  }
}
