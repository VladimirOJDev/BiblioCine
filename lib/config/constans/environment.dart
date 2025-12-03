import 'package:flutter_dotenv/flutter_dotenv.dart';

//Clase que contiene constantes usadas en la app

class Environment {
  static String movieDbKey = dotenv.env['MOVIE_KEY']??'No existe el API Key';
}