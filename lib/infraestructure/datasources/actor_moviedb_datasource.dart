

import 'package:biblio_cine_app/config/constans/environment.dart';
import 'package:biblio_cine_app/domain/datasources/actors_datasource.dart';
import 'package:biblio_cine_app/domain/entities/actor.dart';
import 'package:biblio_cine_app/infraestructure/mappers/actor_mapper.dart';
import 'package:biblio_cine_app/infraestructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {

    //Url http con dio 
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    queryParameters: {
      'api_key':Environment.movieDbKey,
      'language': 'es-MX'
    }
  ));

  @override
  Future<List<Actor>> getActorByMovie(int movieId)async {

    final response = await dio.get('movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(response.data);

    final List<Actor> actors = creditsResponse.cast.map(
      (cast)=> ActorMapper.castToEntity(cast)
    ).toList();
    
   return actors;
  }


}