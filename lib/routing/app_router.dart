import 'package:go_router/go_router.dart';
import 'package:personal_website/features/home/presentation/screens/home_screen.dart';
import 'package:personal_website/features/info/presentation/screens/info_hub_screen.dart';
import 'package:personal_website/features/info/presentation/screens/topic/about_me_screen.dart';
import 'package:personal_website/features/info/presentation/screens/topic/games_screen.dart';
import 'package:personal_website/features/info/presentation/screens/topic/github_screen.dart';
import 'package:personal_website/features/info/presentation/screens/topic/music_screen.dart';
import 'package:personal_website/features/info/presentation/screens/topic/system_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          NoTransitionPage(key: state.pageKey, child: const HomeScreen()),
    ),
    GoRoute(
      path: '/info',
      pageBuilder: (context, state) =>
          NoTransitionPage(key: state.pageKey, child: const InfoHubScreen()),
      routes: [
        GoRoute(
          path: 'about_me',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const AboutMeScreen(),
          ),
        ),
        GoRoute(
          path: 'github',
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: const GithubScreen()),
        ),
        GoRoute(
          path: 'music',
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: const MusicScreen()),
        ),
        GoRoute(
          path: 'system',
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: const SystemScreen()),
        ),
        GoRoute(
          path: 'games',
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: const GamesScreen()),
        ),
      ],
    ),
  ],
);
