import 'package:flutter/material.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool filled;

  const AppButton({
    required this.label,
    required this.onPressed,
    this.filled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMobile(context) ? MediaQuery.of(context).size.width * 0.95 : 450,
      height: 86,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: filled ? AppColors.primary : Colors.black,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(10.0)),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.button(
            context,
          ).copyWith(color: filled ? Colors.black : AppColors.textPrimary),
        ),
      ),
    );
  }
}
