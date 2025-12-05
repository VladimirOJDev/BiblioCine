
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';


//Instancia de MoviesNotifier
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );

});


typedef MovieCallBack = Future<List<Movie>> Function({int page});

//Clase que sirve para manjear en este caso una list de movie
class MoviesNotifier extends StateNotifier<List<Movie>>{
  
  int currentPage = 0;
  MovieCallBack fetchMoreMovies;
  
  MoviesNotifier({
    required this.fetchMoreMovies
  }):super([]);

  Future<void> loadNextPage()async{
    currentPage++;
    

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }

}