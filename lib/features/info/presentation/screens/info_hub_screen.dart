import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';
import 'package:personal_website/features/info/presentation/widgets/hub_button.dart';

class InfoHubScreen extends StatefulWidget {
  const InfoHubScreen({super.key});

  @override
  State<InfoHubScreen> createState() => _InfoHubScreenState();
}

class _InfoHubScreenState extends State<InfoHubScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const int _itemCount = 14;

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
                          animation: _itemAnimation(0),
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
                      animation: _itemAnimation(1),
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
                      animation: _itemAnimation(2),
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
                          animation: _itemAnimation(3),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: Container(
                            width: isMobile(context)
                                ? MediaQuery.of(context).size.width * 0.95
                                : 550,
                            height: 4,
                            color: Colors.white,
                          ),
                        ),
                        SlideFadeIn(
                          animation: _itemAnimation(4),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "ABOUT ME",
                            onPressed: () => "",
                            pRanked: true,
                          ),
                        ),
                        SlideFadeIn(
                          animation: _itemAnimation(5),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "GITHUB",
                            onPressed: () => "",
                            pRanked: true,
                          ),
                        ),
                        SlideFadeIn(
                          animation: _itemAnimation(6),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(label: "MUSIC", onPressed: () => ""),
                        ),
                        SlideFadeIn(
                          animation: _itemAnimation(7),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "TECHNOLOGIES",
                            onPressed: () => "",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    SlideFadeIn(
                      animation: _itemAnimation(8),
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
                          animation: _itemAnimation(9),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: Container(
                            width: isMobile(context)
                                ? MediaQuery.of(context).size.width * 0.95
                                : 550,
                            height: 4,
                            color: Colors.white,
                          ),
                        ),
                        SlideFadeIn(
                          animation: _itemAnimation(10),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "SYSTEM INFO",
                            onPressed: () => "",
                          ),
                        ),
                        SlideFadeIn(
                          animation: _itemAnimation(11),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "GAME ACTIVITY",
                            onPressed: () => "",
                          ),
                        ),
                        SlideFadeIn(
                          animation: _itemAnimation(12),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(
                            label: "WEATHER",
                            onPressed: () => "",
                          ),
                        ),
                        SlideFadeIn(
                          animation: _itemAnimation(13),
                          offsetY: isMobile(context) ? 20.0 : 40.0,
                          child: HubButton(label: "LINKS", onPressed: () => ""),
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
