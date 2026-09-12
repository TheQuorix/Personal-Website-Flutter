import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/animations/staggered_animation_controller.dart';
import 'package:personal_website/core/widgets/custom_scrollbar.dart';
import 'package:personal_website/core/widgets/link.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';
import 'package:personal_website/core/providers/info_provider.dart';
import 'package:personal_website/features/info/presentation/widgets/info_row.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen>
    with SingleTickerProviderStateMixin {
  late final StaggeredAnimationController _anim;
  late final ScrollController _scrollController;

  String _currentTime = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _anim = StaggeredAnimationController(vsync: this, itemCount: 40)..forward();
    _scrollController = ScrollController();

    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    });
  }

  @override
  void dispose() {
    _anim.dispose();
    _scrollController.dispose();
    _timer?.cancel();
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
        body: CustomScrollbar(
          anim: _anim,
          controller: _scrollController,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
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
                                onTap: () => context.go('/info'),
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
                              "--ABOUT ME--",
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
                  SizedBox(
                    width: isMobile(context)
                        ? MediaQuery.of(context).size.width * 0.95
                        : 550,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InfoSection(anim: _anim, currentTime: _currentTime),
                        const SizedBox(height: 20.0),

                        _MeSection(anim: _anim),
                        const SizedBox(height: 20.0),

                        _TechnologiesSection(anim: _anim),
                        const SizedBox(height: 20.0),

                        _LinksSection(anim: _anim),
                        const SizedBox(height: 60.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final StaggeredAnimationController _anim;
  final String currentTime;

  const _InfoSection({required this._anim, required this.currentTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(2),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text("INFO", style: AppTextStyles.label(context)),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(3),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(height: 4, color: Colors.white),
        ),
        InfoRow(
          leftPart: "NAME:",
          rightPart: "TIMUR",
          anim: _anim,
          animationIndex: 4,
        ),
        InfoRow(
          leftPart: "AGE:",
          rightPart: "19",
          anim: _anim,
          animationIndex: 5,
        ),
        InfoRow(
          leftPart: "PRONOUNS:",
          rightPart: "HE/HIM",
          anim: _anim,
          animationIndex: 6,
        ),
        InfoRow(
          leftPart: "LANGS:",
          rightPart: "RU, EN (LEARNING)",
          anim: _anim,
          animationIndex: 7,
        ),
        Consumer(
          builder: (context, ref, child) {
            final infoAsync = ref.watch(infoProvider);
            return infoAsync.when(
              loading: () => InfoRow(
                leftPart: "FROM:",
                rightPart: "MOSCOW (LOADING...)",
                anim: _anim,
                animationIndex: 8,
              ),
              error: (_, _) => InfoRow(
                leftPart: "FROM:",
                rightPart: "MOSCOW (ERROR!)",
                anim: _anim,
                animationIndex: 8,
              ),
              data: (info) => InfoRow(
                leftPart: "FROM:",
                rightPart: "MOSCOW (${info.weather.temp.round()}°)",
                anim: _anim,
                animationIndex: 8,
              ),
            );
          },
        ),
        InfoRow(
          leftPart: "TIMEZONE:",
          rightPart: "UTC+3",
          anim: _anim,
          animationIndex: 9,
        ),
        InfoRow(
          leftPart: "CURRENT TIME:",
          rightPart: currentTime,
          anim: _anim,
          animationIndex: 10,
        ),
        InfoRow(
          leftPart: "LEARNING:",
          rightPart: "FLUTTER, GO",
          anim: _anim,
          animationIndex: 11,
        ),
      ],
    );
  }
}

class _MeSection extends StatelessWidget {
  final StaggeredAnimationController _anim;

  const _MeSection({required this._anim});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(12),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text("ME", style: AppTextStyles.label(context)),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(13),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(height: 4, color: Colors.white),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(14),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(
            color: AppColors.background,
            child: Text(
              isMobile(context)
                  ? "I   am    an   18-year-old"
                  : "I    am    an    18-year-old",
              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(15),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(
            color: AppColors.background,
            child: Text(
              isMobile(context)
                  ? "developer from  Russia who"
                  : "developer  from  Russia  who",
              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(16),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(
            color: AppColors.background,
            child: Text(
              isMobile(context)
                  ? "has not  yet  decided on a"
                  : "has  not  yet decided  on  a",
              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(17),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(
            color: AppColors.background,
            child: Text(
              isMobile(context)
                  ? "career   path.    At   the"
                  : "career path. At the  moment,",
              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(18),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(
            color: AppColors.background,
            child: Text(
              isMobile(context)
                  ? "moment, I am interested in"
                  : "I  am  interested  in mobile",
              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(19),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(
            color: AppColors.background,
            child: Text(
              isMobile(context)
                  ? "mobile  development  using"
                  : "development  using   Flutter",
              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(20),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(
            color: AppColors.background,
            child: Text(
              isMobile(context)
                  ? "Flutter    and     backend"
                  : "and    backend   development",
              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(21),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(
            color: AppColors.background,
            child: Text(
              isMobile(context) ? "development    using   Go." : "using Go.",

              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _TechnologiesSection extends StatelessWidget {
  final StaggeredAnimationController _anim;

  const _TechnologiesSection({required this._anim});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(22),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text("TECHNOLOGIES", style: AppTextStyles.label(context)),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(23),
          offsetY: isMobile(context) ? 20.0 : 10.0,
          child: Container(height: 4, color: Colors.white),
        ),
        InfoRow(
          leftPart: "FLUTTER",
          rightPart: "CURRENT",
          anim: _anim,
          animationIndex: 24,
        ),
        InfoRow(
          leftPart: "GO",
          rightPart: "CURRENT",
          anim: _anim,
          animationIndex: 25,
        ),
        InfoRow(
          leftPart: "UNITY & C#",
          rightPart: "INTERESTED",
          anim: _anim,
          animationIndex: 26,
        ),
        InfoRow(
          leftPart: "ARDUINO",
          rightPart: "INTERESTED",
          anim: _anim,
          animationIndex: 27,
        ),
        InfoRow(
          leftPart: "KOTLIN & JAVA",
          rightPart: "",
          anim: _anim,
          animationIndex: 28,
        ),
        InfoRow(
          leftPart: "PYTHON",
          rightPart: "",
          anim: _anim,
          animationIndex: 29,
        ),
        InfoRow(
          leftPart: "RUST",
          rightPart: "",
          anim: _anim,
          animationIndex: 30,
        ),
      ],
    );
  }
}

class _LinksSection extends StatelessWidget {
  final StaggeredAnimationController _anim;

  const _LinksSection({required this._anim});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(31),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text("TECHNOLOGIES", style: AppTextStyles.label(context)),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(32),
          offsetY: isMobile(context) ? 20.0 : 10.0,
          child: Container(height: 4, color: Colors.white),
        ),
        Link(
          label: "TELEGRAM",
          url: "https://t.me/thequorix",
          animation: _anim.getAnimation(33),
        ),
        Link(
          label: "DISCORD",
          url: "https://discord.com/users/408268839206256652",
          animation: _anim.getAnimation(34),
        ),
        Link(
          label: "STEAM",
          url: "https://steamcommunity.com/profiles/76561199108831532/",
          animation: _anim.getAnimation(35),
        ),
        Link(
          label: "GITHUB",
          url: "https://github.com/TheQuorix",
          animation: _anim.getAnimation(36),
        ),
        Link(
          label: "HACKATIME",
          url: "https://hackatime.hackclub.com/@quorix",
          animation: _anim.getAnimation(37),
        ),
        Link(
          label: "MY DISCORD SERVER",
          url: "https://discord.gg/CKkdMZTmcA",
          animation: _anim.getAnimation(38),
        ),
        Link(
          label: "MY DEV CHANNEL",
          url: "https://t.me/quorix_dev",
          animation: _anim.getAnimation(39),
        ),
      ],
    );
  }
}
