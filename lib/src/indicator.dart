import 'package:flutter/material.dart';

class Indicator {
  Indicator({
    this.animationController,
    this.widget,
    this.builder,
  });

  final AnimationController animationController;
  final Widget widget;
  final WidgetBuilder builder;
}
