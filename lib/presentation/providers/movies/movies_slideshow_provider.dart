import 'package:biblio_cine_app/domain/entities/movie.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'movies_providers.dart';

part 'movies_slideshow_provider.g.dart';

// final moviesSlideshowProvider = Provider<List<Movie>>((ref) {

//   final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); //se puede llamar un provider

//   if(nowPlayingMovies.isEmpty)return[];

//   return nowPlayingMovies.sublist(0,6);
// }); 

@riverpod 
List<Movie> moviesSlideshow (Ref ref){
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); //se puede llamar un provider

  if(nowPlayingMovies.isEmpty)return[];

  return nowPlayingMovies.sublist(0,6);
}

