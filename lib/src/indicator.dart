import 'package:flutter/material.dart';

/// Mediates indicator building and animation.
class Indicator {
  Indicator({
    this.normalController,
    this.highlightedController,
    this.widget,
    this.builder,
    this.index,
  });

  final AnimationController normalController;
  final AnimationController highlightedController;
  final Widget widget;
  final WidgetBuilder builder;
  final int index;

  void dispose() {
    normalController.dispose();
    highlightedController.dispose();
  }
}
