

import 'package:biblio_cine_app/infrastructure/datasources/remote/actor_moviedb_datasource.dart';
import 'package:biblio_cine_app/infrastructure/repositories/actor_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_repository_provider.g.dart';

@riverpod 
ActorRepositoryImpl actorsRepository(Ref ref){
  return ActorRepositoryImpl(datasource: ActorMoviedbDatasource());
}
