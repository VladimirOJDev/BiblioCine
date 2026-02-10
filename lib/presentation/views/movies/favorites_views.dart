import 'package:flutter/material.dart';

class FavoritesViews extends StatelessWidget {
  const FavoritesViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favorites view"),
      ),
      body: Center(
        child: Text("Favoritos"),
      ),
      
    );
  }
}