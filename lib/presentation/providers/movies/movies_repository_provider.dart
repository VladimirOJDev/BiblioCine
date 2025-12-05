//Creará la instancia del movie repository imnpl


import 'package:biblio_cine_app/infraestructure/datasources/moviedb_datasource.dart';
import 'package:biblio_cine_app/infraestructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//El repositorio es inmutable 
final movieRepositoryProvider = Provider((ref) {

    return MovieRepositoryImpl(datasource: MoviedbDatasource());
},);