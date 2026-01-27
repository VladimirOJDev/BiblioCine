import 'package:biblio_cine_app/domain/entities/actor.dart';
import 'package:biblio_cine_app/presentation/providers/actors/actors_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_by_movie_provider.g.dart';

//segun el id de la movie guardamos una lista de actores de la movie
/*
 * {
 *  '3432442': <Actor>[],
 *  '3432442': <Actor>[],
 *  '3432442': <Actor>[],
 * } 
 */


@riverpod 
class ActorsByMovie extends _$ActorsByMovie {


  @override
  Map<String,List<Actor>> build(){

    return{};
  }


   Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final repository = ref.read(actorsRepositoryProvider);
    final actors = await repository.getActorByMovie(movieId);

    state = {...state, movieId: actors};

  }
}

