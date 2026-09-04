import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/animations/staggered_animation_controller.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';
import 'package:personal_website/features/info/presentation/controllers/watched_buttons_controller.dart';
import 'package:personal_website/features/info/presentation/widgets/hub_button.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoHubScreen extends StatefulWidget {
  const InfoHubScreen({super.key});

  @override
  State<InfoHubScreen> createState() => _InfoHubScreenState();
}

class _InfoHubScreenState extends State<InfoHubScreen>
    with SingleTickerProviderStateMixin {
  late final StaggeredAnimationController _anim;
  final _watchedController = WatchedButtonsController();

  @override
  void initState() {
    super.initState();
    _anim = StaggeredAnimationController(vsync: this, itemCount: 14)..forward();
    _watchedController.addListener(_onWatchedChanged);
    _watchedController.load();
  }

  void _onWatchedChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _watchedController.removeListener(_onWatchedChanged);
    _watchedController.dispose();
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
        body: SingleChildScrollView(
          child: Column(
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
                            onTap: () => context.go('/'),
                            child: Text(
                              "←",
                              style: AppTextStyles.back(context),
                            ),
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
                          "--INFO--",
                          style: AppTextStyles.header(context),
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
              SizedBox(
                width: isMobile(context)
                    ? MediaQuery.of(context).size.width * 0.95
                    : 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideFadeIn(
                      animation: _anim.getAnimation(2),
                      offsetY: isMobile(context) ? 20.0 : 40.0,
                      child: Text(
                        "PRIMARY",
                        style: AppTextStyles.label(context),
                      ),
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        SlideFadeIn(
                          animation: _anim.getAnimation(3),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: Container(height: 4, color: Colors.white),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(4),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "ABOUT ME",
                            onPressed: () {
                              _watchedController.markWatched(
                                WatchedButtonsController.keyAboutMe,
                              );
                              context.go('/info/about_me');
                            },
                            watched: _watchedController.isWatched(
                              WatchedButtonsController.keyAboutMe,
                            ),
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(5),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "GITHUB",
                            onPressed: () {
                              _watchedController.markWatched(
                                WatchedButtonsController.keyGithub,
                              );
                              context.go('/info/github');
                            },
                            watched: _watchedController.isWatched(
                              WatchedButtonsController.keyGithub,
                            ),
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(6),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "MUSIC",
                            onPressed: () {
                              _watchedController.markWatched(
                                WatchedButtonsController.keyMusic,
                              );
                              context.go('/info/music');
                            },
                            watched: _watchedController.isWatched(
                              WatchedButtonsController.keyMusic,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    SlideFadeIn(
                      animation: _anim.getAnimation(7),
                      offsetY: isMobile(context) ? 20.0 : 40.0,
                      child: Text(
                        "SECONDARY",
                        style: AppTextStyles.label(context),
                      ),
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        SlideFadeIn(
                          animation: _anim.getAnimation(8),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: Container(height: 4, color: Colors.white),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(9),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "SYSTEM INFO",
                            onPressed: () {
                              _watchedController.markWatched(
                                WatchedButtonsController.keySystemInfo,
                              );
                              context.go('/info/system_info');
                            },
                            watched: _watchedController.isWatched(
                              WatchedButtonsController.keySystemInfo,
                            ),
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(10),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "GAME ACTIVITY",
                            onPressed: () {
                              _watchedController.markWatched(
                                WatchedButtonsController.keyGameActivity,
                              );
                              context.go('/info/game_activity');
                            },
                            watched: _watchedController.isWatched(
                              WatchedButtonsController.keyGameActivity,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    SlideFadeIn(
                      animation: _anim.getAnimation(11),
                      offsetY: isMobile(context) ? 20.0 : 40.0,
                      child: Text(
                        "DESIGN INSPIRATION",
                        style: AppTextStyles.label(context),
                      ),
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        SlideFadeIn(
                          animation: _anim.getAnimation(12),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: Container(height: 4, color: Colors.white),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(13),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "ULTRAKILL",
                            watched: _watchedController.isWatched(
                              WatchedButtonsController.keyUltrakill,
                            ),
                            onPressed: () async {
                              _watchedController.markWatched(
                                WatchedButtonsController.keyUltrakill,
                              );
                              final url = Uri.parse(
                                'https://store.steampowered.com/app/1229490/ULTRAKILL/',
                              );
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            },
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
    );
  }
}
