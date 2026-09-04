import 'package:flutter/material.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';

class HubButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool watched;

  const HubButton({
    required this.label,
    required this.onPressed,
    this.watched = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMobile(context) ? MediaQuery.of(context).size.width * 0.95 : 550,
      height: 86,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: watched ? AppColors.pRankedButton : Colors.black,
          side: BorderSide(
            color: watched ? AppColors.pRankedButton : AppColors.border,
            width: 2,
          ),
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(10.0)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label, style: AppTextStyles.button(context)),
            watched
                ? Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text("P", style: AppTextStyles.button(context)),
                  )
                : Container(
                    width: 50,
                    height: 50,
                    decoration: const ShapeDecoration(
                      shape: BeveledRectangleBorder(
                        side: BorderSide(color: AppColors.border, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
