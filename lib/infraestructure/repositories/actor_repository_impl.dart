
import 'package:biblio_cine_app/domain/datasources/actors_datasource.dart';
import 'package:biblio_cine_app/domain/entities/actor.dart';
import 'package:biblio_cine_app/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDatasource datasource;

  ActorRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActorByMovie(int movieId)async{
    return datasource.getActorByMovie(movieId);
  }



}