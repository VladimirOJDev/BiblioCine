

import 'package:biblio_cine_app/domain/datasources/movies_datasource.dart';
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/domain/repositories/movies_repository.dart';

//LLama al datasource 
class MovieRepositoryImpl extends MoviesRepository{

  //llamada a la clase abstracta de datasource del dominio
  final MoviesDatasource datasource; 

  MovieRepositoryImpl({
    required this.datasource
  });

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
      return datasource.getNowPlaying(page: page);
  }

}