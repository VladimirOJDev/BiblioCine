import 'package:flutter/material.dart';

import 'package:biblio_cine_app/config/router/app_router.dart';
import 'package:biblio_cine_app/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter, //instancia de router
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
