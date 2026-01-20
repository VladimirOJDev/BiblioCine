import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:biblio_cine_app/presentation/providers/movies/movies_repository_provider.dart';



final movieInfoProvider = StateNotifierProvider((ref){

  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie:movieRepository.getMovieById);
}); 


//tipo de dato que recibe una funcion que retorna un Future<Movie> y recibe un String
typedef GetMoviewCallBack = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>>{

  final GetMoviewCallBack getMovie;

  MovieMapNotifier({
    required this.getMovie
  }):super({});

  Future<void> load(String movieId) async{

    //Rectifica si el id ya había cargado
    if(state[movieId] !=null) return;

    final movie = await getMovie(movieId);

    state = {...state, movieId:movie};
  }
}  