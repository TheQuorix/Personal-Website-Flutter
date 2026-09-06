import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/core/models/info/github/github_day_model.dart';
import 'package:personal_website/core/models/info/github/github_week_model.dart';
import 'package:personal_website/core/providers/info_provider.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/animations/staggered_animation_controller.dart';
import 'package:personal_website/core/widgets/custom_scrollbar.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';
import 'package:personal_website/features/info/presentation/widgets/info_row.dart';

class GithubScreen extends StatefulWidget {
  const GithubScreen({super.key});

  @override
  State<GithubScreen> createState() => _GithubScreenState();
}

class _GithubScreenState extends State<GithubScreen>
    with SingleTickerProviderStateMixin {
  late final StaggeredAnimationController _anim;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _anim = StaggeredAnimationController(vsync: this, itemCount: 15)..forward();
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
                              "--GITHUB--",
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
                        _GithubSection(anim: _anim),
                        const SizedBox(height: 20.0),

                        _StatsSection(anim: _anim),
                        const SizedBox(height: 20.0),
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

class _GithubSection extends StatelessWidget {
  final StaggeredAnimationController _anim;

  const _GithubSection({required this._anim});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(2),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text("ACTIVITY", style: AppTextStyles.label(context)),
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
                  data: (info) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5.0,
                    children: info.github.calendar
                        .skip(
                          (info.github.calendar.length - 11).clamp(
                            0,
                            info.github.calendar.length,
                          ),
                        )
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                          final index = entry.key;
                          final week = entry.value;
                          return _GithubWeek(
                            weekModel: week,
                            animation: _anim.getAnimation(index + 3),
                          );
                        })
                        .toList(),
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

class _StatsSection extends StatelessWidget {
  final StaggeredAnimationController _anim;

  const _StatsSection({required this._anim});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(4),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text("STATS", style: AppTextStyles.label(context)),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(5),
          offsetY: isMobile(context) ? 20.0 : 10.0,
          child: Container(height: 4, color: Colors.white),
        ),
        Consumer(
          builder: (context, ref, child) {
            final infoAsync = ref.watch(infoProvider);
            return infoAsync.when(
              loading: () => InfoRow(
                leftPart: "CONTRIBUTIONS/YR",
                rightPart: "?",
                anim: _anim,
                animationIndex: 6,
              ),
              error: (_, _) => InfoRow(
                leftPart: "CONTRIBUTIONS/YR",
                rightPart: "ERR",
                anim: _anim,
                animationIndex: 7,
              ),
              data: (info) => InfoRow(
                leftPart: "CONTRIBUTIONS/YR",
                rightPart: "${info.github.contributions}",
                anim: _anim,
                animationIndex: 8,
              ),
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final infoAsync = ref.watch(infoProvider);
            return infoAsync.when(
              loading: () => InfoRow(
                leftPart: "FOLLOWERS",
                rightPart: "?",
                anim: _anim,
                animationIndex: 9,
              ),
              error: (_, _) => InfoRow(
                leftPart: "FOLLOWERS",
                rightPart: "ERR",
                anim: _anim,
                animationIndex: 9,
              ),
              data: (info) => InfoRow(
                leftPart: "FOLLOWERS",
                rightPart: "${info.github.followers}",
                anim: _anim,
                animationIndex: 9,
              ),
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final infoAsync = ref.watch(infoProvider);
            return infoAsync.when(
              loading: () => InfoRow(
                leftPart: "REPOS",
                rightPart: "?",
                anim: _anim,
                animationIndex: 10,
              ),
              error: (_, _) => InfoRow(
                leftPart: "REPOS",
                rightPart: "ERR",
                anim: _anim,
                animationIndex: 10,
              ),
              data: (info) => InfoRow(
                leftPart: "REPOS",
                rightPart: "${info.github.repos}",
                anim: _anim,
                animationIndex: 10,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _GithubWeek extends StatelessWidget {
  final GithubWeekModel weekModel;
  final Animation<double> animation;

  const _GithubWeek({required this.weekModel, required this.animation});

  @override
  Widget build(BuildContext context) {
    return SlideFadeIn(
      animation: animation,
      offsetX: isMobile(context) ? 10.0 : 20.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 5.0,
        children: weekModel.days.map((day) {
          return _GithubDay(dayModel: day);
        }).toList(),
      ),
    );
  }
}

class _GithubDay extends StatelessWidget {
  final GithubDayModel dayModel;
  const _GithubDay({required this.dayModel});

  Color _getColor(int level) {
    switch (level) {
      case 1:
        return Colors.white.withValues(alpha: 25);
      case 2:
        return Colors.white.withValues(alpha: 50);
      case 3:
        return Colors.white.withValues(alpha: 75);
      case 4:
        return Colors.white;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _HoverableGithubCell(
      baseColor: _getColor(dayModel.level),
      hoverColor: AppColors.pRankedButton,
      count: dayModel.count,
    );
  }
}

class _HoverableGithubCell extends StatefulWidget {
  final Color baseColor;
  final Color hoverColor;
  final int count;

  const _HoverableGithubCell({
    required this.baseColor,
    required this.hoverColor,
    required this.count,
  });

  @override
  State<_HoverableGithubCell> createState() => _HoverableGithubCellState();
}

class _HoverableGithubCellState extends State<_HoverableGithubCell> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool hoverable = widget.count > 0;
    return MouseRegion(
      cursor: hoverable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        width: isMobile(context) ? 32 : 45,
        height: isMobile(context) ? 32 : 45,
        decoration: ShapeDecoration(
          color: _isHovered && hoverable ? widget.hoverColor : widget.baseColor,
          shape: BeveledRectangleBorder(
            side: BorderSide(
              color: _isHovered && hoverable
                  ? AppColors.pRankedButton
                  : AppColors.border,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: AppTextStyles.console(context).copyWith(
              color: _isHovered && hoverable
                  ? Colors.black
                  : Colors.transparent,
            ),
            child: Text(widget.count.toString()),
          ),
        ),
      ),
    );
  }
}
