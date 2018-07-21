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
            _buildExample3()
          ],
        ),
      ),
    );
  }

  PageViewIndicator _buildExample1() {
    return PageViewIndicator(
      pageController: pageController,
      length: length,
      normalBuilder: (animationController) => Circle(
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
    );
  }

  PageViewIndicator _buildExample2() {
    return PageViewIndicator(
      pageController: pageController,
      length: length,
      normalBuilder: (animationController) => Circle(
            size: 8.0,
            color: Colors.black87,
          ),
      highlightedBuilder: (animationController) => ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: Circle(
              size: 8.0,
              color: Colors.white,
            ),
          ),
    );
  }

  PageViewIndicator _buildExample3() {
    return PageViewIndicator(
      pageController: pageController,
      length: length,
      normalBuilder: (animationController) => ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: Icon(
              Icons.favorite,
              color: Colors.black87,
            ),
          ),
      highlightedBuilder: (animationController) => ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: Icon(
              Icons.star,
              color: Colors.white,
            ),
          ),
    );
  }
}

void main() => runApp(App());
