import 'package:biblio_cine_app/domain/entities/movie.dart';

//El repositorio permite cambiar el datasource (origend de datos)
abstract interface class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page=1});
}

