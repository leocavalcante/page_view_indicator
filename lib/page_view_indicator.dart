library page_view_indicator;

import 'package:flutter/material.dart';
import 'package:page_view_indicator/src/indicator.dart';

export 'src/circle.dart';

typedef Widget IndicatorBuilder(AnimationController controller);

class PageViewIndicator extends StatefulWidget {
  PageViewIndicator({
    Key key,
    this.pageIndexNotifier,
    this.length,
    this.normalBuilder,
    this.highlightedBuilder,
    this.currentPage = 0,
  }) : super(key: key);

  final ValueNotifier<int> pageIndexNotifier;
  final int length;
  final IndicatorBuilder normalBuilder;
  final IndicatorBuilder highlightedBuilder;
  final int currentPage;

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator>
    with TickerProviderStateMixin {
  List<Indicator> _indicators;
  int _prevPage = 0;

  @override
  void initState() {
    super.initState();

    _indicators = List.generate(
        widget.length,
        (index) => Indicator(
            normalController: AnimationController(
              vsync: this,
              duration: Duration(microseconds: 200),
            )..forward(),
            highlightedController: AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 200),
            )));

    _indicators[widget.currentPage].normalController.reverse();
    _indicators[widget.currentPage].highlightedController.forward();

    widget.pageIndexNotifier.addListener(() {
      final currPage = widget.pageIndexNotifier.value;

      if (currPage != _prevPage) {
        _indicators[_prevPage].normalController.forward();
        _indicators[_prevPage].highlightedController.reverse();

        _indicators[currPage].normalController.reverse();
        _indicators[currPage].highlightedController.forward();

        _prevPage = currPage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _indicators
          .map<Widget>((indicator) => _buildIndicator(indicator))
          .toList(),
    );
  }

  Widget _buildIndicator(Indicator indicator) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          widget.normalBuilder(indicator.normalController),
          widget.highlightedBuilder(indicator.highlightedController),
        ],
      ),
    );
  }
}
