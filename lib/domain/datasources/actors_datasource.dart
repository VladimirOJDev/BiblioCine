

import 'package:biblio_cine_app/domain/entities/actor.dart';

abstract class ActorsDatasource {
   Future<List<Actor>> getActorByMovie(int movieId);
}