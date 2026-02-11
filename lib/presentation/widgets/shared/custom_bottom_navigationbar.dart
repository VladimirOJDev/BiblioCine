import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationbar extends StatelessWidget {

  final StatefulNavigationShell navigationShell;
  const CustomBottomNavigationbar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //Index de la rama actual
      currentIndex: navigationShell.currentIndex,

      onTap: (index){
        //Cambiar de rama
        navigationShell.goBranch(index);
      },

      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: "Inicio"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: "Categorias"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: "Favoritos"
        ),
      ]
    );
  }
} 