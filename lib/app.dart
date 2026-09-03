import 'package:flutter/material.dart';
import 'package:personal_website/core/theme/app_theme.dart';
import 'routing/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Quorix',
      theme: AppTheme.main,
    );
  }
}
