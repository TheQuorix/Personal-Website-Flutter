import 'package:flutter/widgets.dart';
import 'package:personal_website/core/animations/staggered_animation_controller.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';

class InfoRow extends StatelessWidget {
  final String leftPart;
  final String rightPart;
  final StaggeredAnimationController _anim;
  final int animationIndex;

  const InfoRow({
    super.key,
    required this.leftPart,
    required this.rightPart,
    required this._anim,
    required this.animationIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SlideFadeIn(
      animation: _anim.getAnimation(animationIndex),
      offsetY: isMobile(context) ? 10.0 : 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: AppColors.background,
            child: Text(
              leftPart,
              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
          Container(
            color: AppColors.background,
            child: Text(
              rightPart,
              style: AppTextStyles.label(
                context,
              ).copyWith(color: AppColors.textNav, height: 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
