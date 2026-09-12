import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/core/providers/info_provider.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/animations/staggered_animation_controller.dart';
import 'package:personal_website/core/widgets/custom_scrollbar.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';
import 'package:personal_website/features/info/presentation/widgets/game_card.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen>
    with SingleTickerProviderStateMixin {
  late final StaggeredAnimationController _anim;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _anim = StaggeredAnimationController(vsync: this, itemCount: 25)..forward();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _anim.dispose();
    _scrollController.dispose();
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
                              "--GAMES--",
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
                        _RecentGamesSection(anim: _anim),
                        const SizedBox(height: 20.0),

                        _TotalGamesSection(anim: _anim),
                        const SizedBox(height: 40.0),
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

class _RecentGamesSection extends StatelessWidget {
  final StaggeredAnimationController _anim;

  const _RecentGamesSection({required this._anim});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(2),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text("RECENT GAMES", style: AppTextStyles.label(context)),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(3),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(height: 4, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: SlideFadeIn(
            animation: _anim.getAnimation(4),
            offsetY: isMobile(context) ? 10.0 : 20.0,
            child: Consumer(
              builder: (context, ref, child) {
                final infoAsync = ref.watch(infoProvider);
                return infoAsync.when(
                  loading: () =>
                      Text("Loading", style: AppTextStyles.console(context)),
                  error: (_, _) =>
                      Text("Error", style: AppTextStyles.console(context)),
                  data: (info) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10.0,
                    children: info.steam.recent.toList().asMap().entries.map((
                      entry,
                    ) {
                      final index = entry.key;
                      final game = entry.value;

                      return GameCard(
                        gameModel: game,
                        animation: _anim.getAnimation(index + 6),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _TotalGamesSection extends StatelessWidget {
  final StaggeredAnimationController _anim;

  const _TotalGamesSection({required this._anim});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(10),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text(
            "TOP GAMES BY PLAYTIME",
            style: AppTextStyles.label(context),
          ),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(11),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Container(height: 4, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: SlideFadeIn(
            animation: _anim.getAnimation(12),
            offsetY: isMobile(context) ? 10.0 : 20.0,
            child: Consumer(
              builder: (context, ref, child) {
                final infoAsync = ref.watch(infoProvider);
                return infoAsync.when(
                  loading: () =>
                      Text("Loading", style: AppTextStyles.console(context)),
                  error: (_, _) =>
                      Text("Error", style: AppTextStyles.console(context)),
                  data: (info) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10.0,
                    children: info.steam.top.toList().asMap().entries.map((
                      entry,
                    ) {
                      final index = entry.key;
                      final game = entry.value;

                      return GameCard(
                        gameModel: game,
                        animation: _anim.getAnimation(index + 13),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
