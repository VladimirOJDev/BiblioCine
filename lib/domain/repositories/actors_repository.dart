
import 'package:biblio_cine_app/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorByMovie(int movieId);
}
