import 'package:biblio_cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class HomeScreen extends StatelessWidget {

  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("Esta es la pantalla generica no un view"),
      ),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}
