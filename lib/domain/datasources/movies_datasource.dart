

//Interfaz que no se puede instanciar
import 'package:biblio_cine_app/domain/entities/movie.dart';

//Contrato para traer listas de películas de diferentes fuentes
//Es implementado por el datasoruce de la infraestructura
abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page=1});
  
  Future<List<Movie>> getPopular({int page=1});
}

 