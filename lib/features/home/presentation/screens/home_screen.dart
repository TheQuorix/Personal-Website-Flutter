import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/widgets/app_button.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const int _itemCount = 13;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150 * _itemCount + 300),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _itemAnimation(int i) {
    final start = i / _itemCount;
    final end = start + (1 / _itemCount) + 0.15;
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(
        start.clamp(0.0, 1.0),
        end.clamp(0.0, 1.0),
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 0 : 10.0),
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.black38,
            shape: BeveledRectangleBorder(
              side: BorderSide(
                color: isMobile ? Colors.transparent : AppColors.border,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 10.0 : 85.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SlideFadeIn(
                        animation: _itemAnimation(0),
                        offsetX: isMobile ? -20.0 : -40.0,
                        child: Text(
                          "QUORIX",
                          style: AppTextStyles.logo(context),
                        ),
                      ),
                      SlideFadeIn(
                        animation: _itemAnimation(1),
                        offsetX: isMobile ? -20.0 : -40.0,
                        child: Text(
                          "EARLY_ACCESS READY",
                          style: AppTextStyles.console(context),
                        ),
                      ),
                      const SizedBox(height: 85.0),
                      SlideFadeIn(
                        animation: _itemAnimation(2),
                        offsetX: isMobile ? -20.0 : -40.0,
                        child: Text(
                          "PAGE QUORIX.RU INITIALIZED",
                          style: AppTextStyles.console(context),
                        ),
                      ),
                      SlideFadeIn(
                        animation: _itemAnimation(3),
                        offsetX: isMobile ? -20.0 : -40.0,
                        child: Text(
                          "DIAGNOSTICS...OK",
                          style: AppTextStyles.console(context),
                        ),
                      ),
                      SlideFadeIn(
                        animation: _itemAnimation(4),
                        offsetX: isMobile ? -20.0 : -40.0,
                        child: Text(
                          "PAGE INFO:",
                          style: AppTextStyles.console(context),
                        ),
                      ),
                      SlideFadeIn(
                        animation: _itemAnimation(5),
                        offsetX: isMobile ? -20.0 : -40.0,
                        child: Text(
                          "172 TOTAL 10 TODAY 93 UNIQUE",
                          style: AppTextStyles.console(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                        child: Column(
                          spacing: 20.0,
                          children: [
                            SlideFadeIn(
                              animation: _itemAnimation(6),
                              offsetX: isMobile ? -20.0 : -40.0,
                              child: AppButton(
                                label: 'INFO',
                                filled: true,
                                onPressed: () => context.go('/info'),
                              ),
                            ),
                            SlideFadeIn(
                              animation: _itemAnimation(7),
                              offsetX: isMobile ? -20.0 : -40.0,
                              child: AppButton(
                                label: 'PROJECTS',
                                onPressed: () => context.go('/projects'),
                              ),
                            ),
                            SlideFadeIn(
                              animation: _itemAnimation(8),
                              offsetX: isMobile ? -20.0 : -40.0,
                              child: AppButton(
                                label: 'COMMENTS',
                                onPressed: () => context.go('/comments'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SlideFadeIn(
                        animation: _itemAnimation(9),
                        offsetX: isMobile ? -20.0 : -40.0,
                        child: Text(
                          "INIT OTORING...OK",
                          style: AppTextStyles.console(context),
                        ),
                      ),
                      Row(
                        spacing: 20.0,
                        children: [
                          SlideFadeIn(
                            animation: _itemAnimation(10),
                            offsetY: isMobile ? 10.0 : 20.0,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                "PREV",
                                style: AppTextStyles.nav(context),
                              ),
                            ),
                          ),
                          SlideFadeIn(
                            animation: _itemAnimation(11),
                            offsetY: isMobile ? 10.0 : 20.0,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                "RANDOM",
                                style: AppTextStyles.nav(context),
                              ),
                            ),
                          ),
                          SlideFadeIn(
                            animation: _itemAnimation(12),
                            offsetY: isMobile ? 10.0 : 20.0,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                "NEXT",
                                style: AppTextStyles.nav(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
