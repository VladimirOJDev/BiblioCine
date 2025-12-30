import 'package:biblio_cine_app/domain/entities/movie.dart';

//El repositorio permite cambiar el datasource (origend de datos)
//Se imelementa en el repositorio de la infraestructura
abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page=1});
  Future<List<Movie>> getPopular({int page=1});
  Future<List<Movie>> getUpcoming({int page=1});
  Future<List<Movie>> getTopRated({int page=1});
}

