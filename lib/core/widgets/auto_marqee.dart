import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AutoMarquee extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double height;
  final double velocity;
  final Duration pauseAfterRound;
  final double blankSpace;

  const AutoMarquee({
    required this.text,
    required this.height,
    this.style,
    this.velocity = 40.0,
    this.pauseAfterRound = const Duration(milliseconds: 1500),
    this.blankSpace = 200.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          maxLines: 1,
          textDirection: TextDirection.ltr,
          textScaler: MediaQuery.textScalerOf(context),
        )..layout();

        final fits = textPainter.width <= constraints.maxWidth;

        if (fits) {
          return SizedBox(
            height: height,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: style,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }

        return SizedBox(
          height: height,
          child: Marquee(
            text: text,
            style: style,
            velocity: velocity,
            pauseAfterRound: pauseAfterRound,
            blankSpace: blankSpace,
          ),
        );
      },
    );
  }
}
