import 'package:biblio_cine_app/config/constans/environment.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {

  static final name = 'home-screen'; //Nombre usado en router

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(Environment.movieDbKey),
      ),
    );
  }
}