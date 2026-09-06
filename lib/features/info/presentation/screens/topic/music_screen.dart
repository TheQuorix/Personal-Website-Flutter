import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/animations/staggered_animation_controller.dart';
import 'package:personal_website/core/widgets/auto_marqee.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';
import 'package:personal_website/core/providers/info_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with SingleTickerProviderStateMixin {
  late final StaggeredAnimationController _anim;

  @override
  void initState() {
    _anim = StaggeredAnimationController(vsync: this, itemCount: 6)..forward();
    super.initState();
  }

  Future<void> _openUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: isMobile(context) ? 20.0 : 40.0,
                  ),
                  child: SizedBox(
                    width: isMobile(context) ? 30.0 : 40.0,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SlideFadeIn(
                        animation: _anim.getAnimation(0),
                        offsetY: isMobile(context) ? -20.0 : -40.0,
                        child: GestureDetector(
                          onTap: () => context.go('/info'),
                          child: Text("←", style: AppTextStyles.back(context)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: isMobile(context) ? 300 : 550,
                  child: SlideFadeIn(
                    animation: _anim.getAnimation(1),
                    offsetY: isMobile(context) ? -20.0 : -40.0,
                    child: Center(
                      child: Text(
                        "--MUSIC--",
                        style: AppTextStyles.miniHeader(context),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: isMobile(context) ? 20.0 : 40.0,
                  ),
                  child: SizedBox(width: isMobile(context) ? 30.0 : 40.0),
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final infoAsync = ref.watch(infoProvider);
                return infoAsync.when(
                  loading: () => Center(
                    child: Text(
                      "Loading",
                      style: AppTextStyles.console(context),
                    ),
                  ),
                  error: (_, _) => Center(
                    child: Text("Error", style: AppTextStyles.console(context)),
                  ),
                  data: (info) => SizedBox(
                    width: isMobile(context)
                        ? MediaQuery.of(context).size.width * 0.95
                        : 550,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100.0),
                        SlideFadeIn(
                          animation: _anim.getAnimation(2),
                          offsetX: isMobile(context) ? -10.0 : -20.0,
                          child: _MusicDisk(url: info.music.imageUrl),
                        ),
                        const SizedBox(height: 20.0),
                        SlideFadeIn(
                          animation: _anim.getAnimation(3),
                          offsetX: isMobile(context) ? -10.0 : -20.0,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => _openUrl(info.music.songUrl),
                              child: SizedBox(
                                height: 70,
                                child: AutoMarquee(
                                  text: info.music.name,
                                  style: AppTextStyles.musicLabel(context),
                                  height: 70,
                                  velocity: 40.0,
                                  pauseAfterRound: const Duration(
                                    milliseconds: 1500,
                                  ),
                                  blankSpace: 200.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(4),
                          offsetX: isMobile(context) ? -10.0 : -20.0,
                          child: SizedBox(
                            height: 50,
                            child: AutoMarquee(
                              text: info.music.artist,
                              style: AppTextStyles.musicAuthor(context),
                              height: 50,
                              velocity: 40.0,
                              pauseAfterRound: const Duration(
                                milliseconds: 1500,
                              ),
                              blankSpace: 200.0,
                            ),
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(5),
                          offsetX: isMobile(context) ? -10.0 : -20.0,
                          child: Text(
                            "NOW PLAYING...${info.music.nowPlaying ? "TRUE" : "FALSE"}",
                            style: AppTextStyles.musicStatus(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MusicDisk extends StatefulWidget {
  final String url;

  const _MusicDisk({required this.url});

  @override
  State<_MusicDisk> createState() => _MusicDiskState();
}

class _MusicDiskState extends State<_MusicDisk>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 32),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = isMobile(context)
        ? MediaQuery.of(context).size.width * 0.95
        : 550.0;

    return SizedBox(
      width: size,
      height: size,
      child: RotationTransition(
        turns: _rotationController,
        child: Stack(
          children: [
            ClipPath(
              clipper: const _PolygonClipper(sides: 10),
              child: CachedNetworkImage(
                imageUrl: widget.url,
                width: size,
                height: size,

                color: Colors.grey.shade500,
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: size,
                  height: size,
                  color: Colors.grey.shade600,
                ),
                errorWidget: (context, url, error) => Container(
                  width: size,
                  height: size,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            CustomPaint(
              size: Size(size, size),
              painter: _PolygonBorderPainter(
                sides: 10,
                color: AppColors.border,
                strokeWidth: 3,
              ),
            ),
            Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: const ShapeDecoration(
                  color: Colors.black,
                  shape: BeveledRectangleBorder(
                    side: BorderSide(color: AppColors.border, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolygonClipper extends CustomClipper<Path> {
  final int sides;
  final double rotation;

  const _PolygonClipper({this.sides = 10, this.rotation = 0});

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    for (int i = 0; i < sides; i++) {
      final angle = (2 * pi * i / sides) - pi / 2 + rotation;
      final point = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _PolygonClipper oldClipper) {
    return oldClipper.sides != sides || oldClipper.rotation != rotation;
  }
}

class _PolygonBorderPainter extends CustomPainter {
  final int sides;
  final Color color;
  final double strokeWidth;

  _PolygonBorderPainter({
    required this.sides,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _PolygonClipper(sides: sides).getClip(size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PolygonBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
