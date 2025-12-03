import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:biblio_cine_app/config/router/app_router.dart';
import 'package:biblio_cine_app/config/theme/app_theme.dart';

//Main envuelto en future para usar dotenv, variables de entorno
//https://pub.dev/packages/flutter_dotenv

Future<void> main() async{

  await dotenv.load(fileName: '.env'); //damos la direccion de los env

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
