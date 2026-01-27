

import 'package:biblio_cine_app/infraestructure/datasources/actor_moviedb_datasource.dart';
import 'package:biblio_cine_app/infraestructure/repositories/actor_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_repository_provider.g.dart';

@riverpod 
ActorRepositoryImpl actorsRepository(Ref ref){
  return ActorRepositoryImpl(datasource: ActorMoviedbDatasource());
}
