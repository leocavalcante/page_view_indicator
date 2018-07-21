library page_view_indicator;

import 'package:flutter/material.dart';
import 'package:page_view_indicator/src/indicator.dart';

export 'src/circle.dart';

typedef Widget IndicatorBuilder(AnimationController controller);

class PageViewIndicator extends StatefulWidget {
  PageViewIndicator({
    Key key,
    this.pageController,
    this.length,
    this.normalBuilder,
    this.highlightedBuilder,
  }) : super(key: key);

  final PageController pageController;
  final int length;
  final IndicatorBuilder normalBuilder;
  final IndicatorBuilder highlightedBuilder;

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState(
      pageController, length, normalBuilder, highlightedBuilder);
}

class _PageViewIndicatorState extends State<PageViewIndicator>
    with TickerProviderStateMixin {
  _PageViewIndicatorState(
    PageController pageController,
    this.length,
    this.normalBuilder,
    this.highlightedBuilder,
  ) {
    pageController.addListener(() {
      final currPage = pageController.page.toInt();

      if (currPage != _prevPage) {
        _indicators[_prevPage].animationController.reverse();
        _indicators[currPage].animationController.forward();
        _prevPage = currPage;
      }
    });
  }

  final int length;
  final IndicatorBuilder normalBuilder;
  final IndicatorBuilder highlightedBuilder;

  List<Indicator> _indicators;

  int _prevPage = 0;

  @override
  void initState() {
    super.initState();

    _indicators = List.generate(
        length,
        (index) => Indicator(
                animationController: AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 100),
            )));
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
          normalBuilder(indicator.animationController),
          highlightedBuilder(indicator.animationController),
        ],
      ),
    );
  }
}
