import 'package:flutter/material.dart';

class SlideFadeIn extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final double offsetX;
  final double offsetY;

  const SlideFadeIn({
    required this.animation,
    required this.child,
    this.offsetX = 0,
    this.offsetY = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(
              offsetX * (1 - animation.value),
              offsetY * (1 - animation.value),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
