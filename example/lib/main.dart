import 'package:flutter/material.dart';
import 'package:page_view_indicator_ns/page_view_indicator.dart';

class App extends StatelessWidget {
  static const length = 3;
  final pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: FractionalOffset.bottomCenter,
          children: <Widget>[
            PageView.builder(
              onPageChanged: (index) => pageIndexNotifier.value = index,
              itemCount: length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(color: Colors.accents[index]),
                );
              },
            ),
            _buildExample1()
          ],
        ),
      ),
    );
  }

  PageViewIndicator _buildExample1() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
            size: 8.0,
            color: Colors.black87,
          ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: Circle(
              size: 12.0,
              color: Colors.accents.elementAt((index + 3) * 3),
            ),
          ),
    );
  }
}

void main() => runApp(App());
