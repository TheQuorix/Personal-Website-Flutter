import 'package:flutter/material.dart';

class StaggeredAnimationController {
  final AnimationController controller;
  final int itemCount;
  final double overlap;

  StaggeredAnimationController({
    required TickerProvider vsync,
    required this.itemCount,
    Duration stepDuration = const Duration(milliseconds: 50),
    Duration baseDuration = const Duration(milliseconds: 500),
    this.overlap = 0.15,
  }) : controller = AnimationController(
         vsync: vsync,
         duration: Duration(
           milliseconds:
               (stepDuration.inMilliseconds * itemCount) +
               baseDuration.inMilliseconds,
         ),
       );

  void forward() => controller.forward();

  Animation<double> getAnimation(int index, {Curve curve = Curves.linear}) {
    final start = index / itemCount;
    final end = start + (1 / itemCount) + overlap;

    return CurvedAnimation(
      parent: controller,
      curve: Interval(start.clamp(0.0, 1.0), end.clamp(0.0, 1.0), curve: curve),
    );
  }

  void dispose() {
    controller.dispose();
  }
}
