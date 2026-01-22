import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'movies_providers.dart';

part 'movies_slideshow_provider.g.dart';


@riverpod 
List<Movie> moviesSlideshow (Ref ref){
  final nowPlayingMovies = ref.watch(moviesProvider(MovieCategory.nowPlaying)); //se puede llamar un provider

  if(nowPlayingMovies.isEmpty)return[];

  return nowPlayingMovies.sublist(0,6);
}

