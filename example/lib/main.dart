import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class App extends StatelessWidget {
  static const length = 3;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: FractionalOffset.bottomCenter,
          children: <Widget>[
            PageView.builder(
              controller: pageController,
              itemCount: length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(color: Colors.accents[index]),
                );
              },
            ),
            PageViewIndicator(
              pageController: pageController,
              length: length,
              normalBuilder: (controller) => Circle(
                    size: 8.0,
                    color: Colors.black87,
                  ),
              highlightedBuilder: (animationController) => ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animationController,
                      curve: Curves.ease,
                    ),
                    child: Circle(
                      size: 12.0,
                      color: Colors.black45,
                    ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}

void main() => runApp(App());
