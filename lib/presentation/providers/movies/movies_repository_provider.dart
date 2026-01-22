//Creará la instancia del movie repository imnpl

import 'package:biblio_cine_app/infraestructure/datasources/moviedb_datasource.dart';
import 'package:biblio_cine_app/infraestructure/repositories/movie_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_repository_provider.g.dart';

@riverpod 
MovieRepositoryImpl movieRepository(Ref ref){
  return MovieRepositoryImpl(datasource: MoviedbDatasource());
}