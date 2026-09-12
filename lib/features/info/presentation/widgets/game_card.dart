import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/core/models/info/steam/steam_game_model.dart';
import 'package:personal_website/core/network/api_client.dart';
import 'package:personal_website/core/theme/app_colors.dart';
import 'package:personal_website/core/theme/app_text_styles.dart';
import 'package:personal_website/core/utils/adaptation.dart';
import 'package:personal_website/core/widgets/slide_fade_in.dart';

class GameCard extends StatelessWidget {
  final SteamGameModel gameModel;
  final Animation<double> animation;

  const GameCard({super.key, required this.gameModel, required this.animation});

  @override
  Widget build(BuildContext context) {
    double twoWeekHours = gameModel.playtime2Weeks / 60;
    double totalHours = gameModel.playtimeForever / 60;
    return SlideFadeIn(
      animation: animation,
      offsetY: isMobile(context) ? 10.0 : 20.0,
      child: Row(
        spacing: 10,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  "$backendUrl${gameModel.iconUrl}",
                ),
                fit: BoxFit.cover,
              ),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(
            width: isMobile(context) ? 275 : 440,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gameModel.name,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label(
                    context,
                  ).copyWith(color: AppColors.textNav, height: 1.0),
                ),
                if (twoWeekHours >= 0.01)
                  Text(
                    "${twoWeekHours.toStringAsFixed(1)}h last 2 weeks",
                    style: AppTextStyles.console(context),
                  ),
                Text(
                  "${totalHours.toStringAsFixed(1)}h total",
                  style: AppTextStyles.console(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
