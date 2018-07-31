import 'package:flutter/material.dart';

class Indicator {
  Indicator({
    this.normalController,
    this.highlightedController,
    this.widget,
    this.builder,
  });

  final AnimationController normalController;
  final AnimationController highlightedController;
  final Widget widget;
  final WidgetBuilder builder;

  void dispose() {
    normalController.dispose();
    highlightedController.dispose();
  }
}
