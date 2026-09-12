import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/core/providers/visits_provider.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/animations/staggered_animation_controller.dart';
import 'package:personal_website/core/widgets/app_button.dart';
import 'package:personal_website/core/widgets/link.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final StaggeredAnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = StaggeredAnimationController(vsync: this, itemCount: 15)..forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final offsetX = isMobile ? -20.0 : -40.0;

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
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 10.0 : 85.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlideFadeIn(
                          animation: _anim.getAnimation(0),
                          offsetX: offsetX,
                          child: Text(
                            "QUORIX",
                            style: AppTextStyles.logo(context),
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(1),
                          offsetX: offsetX,
                          child: Container(
                            color: AppColors.background,
                            child: Text(
                              "EARLY_ACCESS READY",
                              style: AppTextStyles.console(context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 85.0),
                        SlideFadeIn(
                          animation: _anim.getAnimation(2),
                          offsetX: offsetX,
                          child: Container(
                            color: AppColors.background,
                            child: Text(
                              "PAGE QUORIX.RU INITIALIZED",
                              style: AppTextStyles.console(context),
                            ),
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(3),
                          offsetX: offsetX,
                          child: Container(
                            color: AppColors.background,
                            child: Text(
                              "DIAGNOSTICS...OK",
                              style: AppTextStyles.console(context),
                            ),
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(4),
                          offsetX: offsetX,
                          child: Container(
                            color: AppColors.background,
                            child: Text(
                              "PAGE INFO:",
                              style: AppTextStyles.console(context),
                            ),
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(5),
                          offsetX: offsetX,
                          child: Container(
                            color: AppColors.background,
                            child: Consumer(
                              builder: (context, ref, child) {
                                final visitsAsync = ref.watch(visitsProvider);
                                return visitsAsync.when(
                                  loading: () => Text(
                                    "? TOTAL ? TODAY ? UNIQUE",
                                    style: AppTextStyles.console(context),
                                  ),
                                  error: (_, _) => Text(
                                    "ERR TOTAL ERR TODAY ERR UNIQUE",
                                    style: AppTextStyles.console(context),
                                  ),
                                  data: (visits) => Text(
                                    "${visits.totalVisits} TOTAL ${visits.dailyVisits[0].total} TODAY ${visits.uniqueVisits} UNIQUE",
                                    style: AppTextStyles.console(context),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            bottom: 20.0,
                          ),
                          child: Column(
                            spacing: 20.0,
                            children: [
                              SlideFadeIn(
                                animation: _anim.getAnimation(6),
                                offsetX: offsetX,
                                child: AppButton(
                                  label: 'INFO',
                                  filled: true,
                                  onPressed: () => context.go('/info'),
                                ),
                              ),
                              SlideFadeIn(
                                animation: _anim.getAnimation(7),
                                offsetX: offsetX,
                                child: AppButton(
                                  label: 'PROJECTS',
                                  onPressed: () => context.go('/projects'),
                                ),
                              ),
                              SlideFadeIn(
                                animation: _anim.getAnimation(8),
                                offsetX: offsetX,
                                child: AppButton(
                                  label: 'COMMENTS',
                                  onPressed: () => context.go('/comments'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SlideFadeIn(
                          animation: _anim.getAnimation(9),
                          offsetX: offsetX,
                          child: Container(
                            color: AppColors.background,
                            child: Text(
                              "INIT OTORING...OK",
                              style: AppTextStyles.console(context),
                            ),
                          ),
                        ),
                        Row(
                          spacing: 20.0,
                          children: [
                            _WebringLink(
                              label: 'PREV',
                              endpoint: 'prev',
                              animation: _anim.getAnimation(10),
                              isMobile: isMobile,
                            ),
                            _WebringLink(
                              label: 'RANDOM',
                              endpoint: 'random',
                              animation: _anim.getAnimation(11),
                              isMobile: isMobile,
                            ),
                            _WebringLink(
                              label: 'NEXT',
                              endpoint: 'next',
                              animation: _anim.getAnimation(12),
                              isMobile: isMobile,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 150.0),
                child: SlideFadeIn(
                  animation: _anim.getAnimation(13),
                  offsetX: 20.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        width: 550,
                        image: AssetImage('assets/images/me.png'),
                      ),
                      Link(
                        label: "by @hakkie_art",
                        url: "https://t.me/hakkie_art",
                        animation: _anim.getAnimation(14),
                        style: AppTextStyles.console(
                          context,
                        ).copyWith(decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WebringLink extends StatelessWidget {
  final String label;
  final String endpoint;
  final Animation<double> animation;
  final bool isMobile;

  const _WebringLink({
    required this.label,
    required this.endpoint,
    required this.animation,
    required this.isMobile,
  });

  Future<void> _openUrl() async {
    final url = Uri.parse('https://webring.otomir23.me/quorix/$endpoint');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return SlideFadeIn(
      animation: animation,
      offsetY: isMobile ? 10.0 : 20.0,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _openUrl,
          child: Container(
            color: AppColors.background,
            child: Text(label, style: AppTextStyles.nav(context)),
          ),
        ),
      ),
    );
  }
}
