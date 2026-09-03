import 'package:go_router/go_router.dart';
import 'package:personal_website/features/home/presentation/screens/home_screen.dart';
import 'package:personal_website/features/info/presentation/screens/info_hub_screen.dart';

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
    ),
  ],
);
