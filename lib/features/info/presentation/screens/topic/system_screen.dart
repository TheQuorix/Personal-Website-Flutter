import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/animations/staggered_animation_controller.dart';
import 'package:personal_website/core/widgets/custom_scrollbar.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';
import 'package:personal_website/features/info/presentation/widgets/info_row.dart';

class SystemScreen extends StatefulWidget {
  const SystemScreen({super.key});

  @override
  State<SystemScreen> createState() => _SystemScreenState();
}

class _SystemScreenState extends State<SystemScreen>
    with SingleTickerProviderStateMixin {
  late final StaggeredAnimationController _anim;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _anim = StaggeredAnimationController(vsync: this, itemCount: 19)..forward();
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
                              "--SYSTEM--",
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
                        _PcSection(anim: _anim),
                        const SizedBox(height: 20.0),

                        _OtherDevicesSection(anim: _anim),
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

class _PcSection extends StatelessWidget {
  final StaggeredAnimationController _anim;

  const _PcSection({required this._anim});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(2),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text("PC", style: AppTextStyles.label(context)),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(3),
          offsetY: isMobile(context) ? 20.0 : 10.0,
          child: Container(height: 4, color: Colors.white),
        ),
        InfoRow(
          leftPart: "OS",
          rightPart: "WINDOWS 11",
          anim: _anim,
          animationIndex: 4,
        ),
        InfoRow(
          leftPart: "SECOND OS",
          rightPart: "NIX OS",
          anim: _anim,
          animationIndex: 5,
        ),
        InfoRow(
          leftPart: "CPU",
          rightPart: "INTEL CORE I3-12100F",
          anim: _anim,
          animationIndex: 6,
        ),
        InfoRow(
          leftPart: "GPU",
          rightPart: "RTX 2060 SUPER",
          anim: _anim,
          animationIndex: 7,
        ),
        InfoRow(
          leftPart: "RAM",
          rightPart: "16GB",
          anim: _anim,
          animationIndex: 8,
        ),
        InfoRow(
          leftPart: "N2ME",
          rightPart: "512GB",
          anim: _anim,
          animationIndex: 9,
        ),
        InfoRow(
          leftPart: "SSD",
          rightPart: "1024GB",
          anim: _anim,
          animationIndex: 10,
        ),
      ],
    );
  }
}

class _OtherDevicesSection extends StatelessWidget {
  final StaggeredAnimationController _anim;

  const _OtherDevicesSection({required this._anim});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideFadeIn(
          animation: _anim.getAnimation(11),
          offsetY: isMobile(context) ? 10.0 : 20.0,
          child: Text("OTHER DEVICES", style: AppTextStyles.label(context)),
        ),
        SlideFadeIn(
          animation: _anim.getAnimation(12),
          offsetY: isMobile(context) ? 20.0 : 10.0,
          child: Container(height: 4, color: Colors.white),
        ),
        InfoRow(
          leftPart: "PHONE",
          rightPart: "SAMSUNG GALAXY A55",
          anim: _anim,
          animationIndex: 13,
        ),
        InfoRow(
          leftPart: "MONITOR",
          rightPart: "1920X1080@165 IPS",
          anim: _anim,
          animationIndex: 14,
        ),
        InfoRow(
          leftPart: "MONITOR",
          rightPart: "1920X1080@75 VA",
          anim: _anim,
          animationIndex: 15,
        ),
        InfoRow(
          leftPart: "HEADPHONES",
          rightPart: "LOGITECH G435",
          anim: _anim,
          animationIndex: 16,
        ),
        InfoRow(
          leftPart: "MOUSE",
          rightPart: "VXE R1 SE+",
          anim: _anim,
          animationIndex: 17,
        ),
        InfoRow(
          leftPart: "KEYBOARD",
          rightPart: "DEXP MACE",
          anim: _anim,
          animationIndex: 18,
        ),
      ],
    );
  }
}
