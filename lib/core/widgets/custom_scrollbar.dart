import 'package:flutter/material.dart';
import 'package:personal_website/core/animations/staggered_animation_controller.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';

class CustomScrollbar extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final StaggeredAnimationController anim;

  const CustomScrollbar({
    required this.controller,
    required this.child,
    required this.anim,
    super.key,
  });

  @override
  State<CustomScrollbar> createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<CustomScrollbar> {
  double? _dragStartThumbTop;
  double? _dragStartPointerY;

  void _handleTrackTap(
    TapDownDetails details,
    double trackHeight,
    double thumbHeight,
  ) {
    final position = widget.controller.position;
    final maxScroll = position.maxScrollExtent;

    final targetThumbTop = (details.localPosition.dy - thumbHeight / 2).clamp(
      0.0,
      trackHeight - thumbHeight,
    );

    final targetScrollOffset =
        (targetThumbTop / (trackHeight - thumbHeight)) * maxScroll;

    widget.controller.jumpTo(targetScrollOffset.clamp(0.0, maxScroll));
  }

  void _handleDragStart(DragStartDetails details, double thumbTop) {
    _dragStartThumbTop = thumbTop;
    _dragStartPointerY = details.globalPosition.dy;
  }

  void _handleDragUpdate(
    DragUpdateDetails details,
    double trackHeight,
    double thumbHeight,
  ) {
    if (_dragStartThumbTop == null || _dragStartPointerY == null) return;

    final position = widget.controller.position;
    final maxScroll = position.maxScrollExtent;

    final deltaY = details.globalPosition.dy - _dragStartPointerY!;
    final newThumbTop = (_dragStartThumbTop! + deltaY).clamp(
      0.0,
      trackHeight - thumbHeight,
    );

    final newScrollOffset =
        (newThumbTop / (trackHeight - thumbHeight)) * maxScroll;

    widget.controller.jumpTo(newScrollOffset.clamp(0.0, maxScroll));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          right: 500,
          top: 50,
          bottom: 50,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final trackHeight = constraints.maxHeight;

              return AnimatedBuilder(
                animation: widget.controller,
                builder: (context, _) {
                  if (!widget.controller.hasClients ||
                      !widget.controller.position.hasContentDimensions) {
                    return const SizedBox.shrink();
                  }

                  final position = widget.controller.position;
                  final maxScroll = position.maxScrollExtent;

                  if (maxScroll <= 0) {
                    return const SizedBox.shrink();
                  }

                  final viewportDimension = position.viewportDimension;
                  final scrollOffset = position.pixels;

                  final thumbRatio =
                      viewportDimension / (maxScroll + viewportDimension);
                  final thumbHeight = (thumbRatio * trackHeight).clamp(
                    24.0,
                    trackHeight,
                  );

                  final thumbTop =
                      (scrollOffset / maxScroll) * (trackHeight - thumbHeight);

                  return SlideFadeIn(
                    animation: widget.anim.getAnimation(0),
                    offsetY: 20.0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTapDown: (details) =>
                          _handleTrackTap(details, trackHeight, thumbHeight),
                      onVerticalDragStart: (details) =>
                          _handleDragStart(details, thumbTop),
                      onVerticalDragUpdate: (details) =>
                          _handleDragUpdate(details, trackHeight, thumbHeight),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Stack(
                          children: [
                            Container(
                              width: 50,
                              height: trackHeight,
                              decoration: const ShapeDecoration(
                                color: AppColors.background,
                                shape: BeveledRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.border,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: thumbTop + 8,
                              left: 8,
                              right: 8,
                              child: Container(
                                height: thumbHeight - 16,
                                decoration: const ShapeDecoration(
                                  color: AppColors.primary,
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                      color: AppColors.border,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
