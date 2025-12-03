

//Interfaz que no se puede instanciar
import 'package:biblio_cine_app/domain/entities/movie.dart';

//Contrato para traer listas de películas de diferentes fuentes
abstract interface class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page=1});
}

