import 'package:flutter/material.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  final String label;
  final String url;
  final Animation<double> animation;
  final TextStyle? style;

  const Link({
    super.key,
    required this.label,
    required this.url,
    required this.animation,
    this.style,
  });

  Future<void> _openUrl() async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle =
        style ??
        AppTextStyles.label(context).copyWith(
          color: AppColors.textNav,
          height: 1.2,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.textNav,
        );

    return SlideFadeIn(
      animation: animation,
      offsetY: isMobile(context) ? 10.0 : 20.0,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _openUrl,
          child: Container(
            color: AppColors.background,
            child: Text(label, style: effectiveStyle),
          ),
        ),
      ),
    );
  }
}
