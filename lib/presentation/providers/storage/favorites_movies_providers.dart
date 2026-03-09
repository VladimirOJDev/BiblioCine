import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_movies_providers.g.dart';

/*
  121231231:Movie,
  223423432:Movie,
  334534533:Movie,
  423232322:Movie
*/
@Riverpod(keepAlive: true)
class FavoritesMovies extends _$FavoritesMovies {

  @override
  Map<int, Movie> build() {
    // Solo devolvemos el estado inicial (un mapa vacío)
    
    return {}; 
  }

  int page = 0;


  Future<List<Movie>> loadNextPage() async{
    final localMovieRepository = ref.watch(localStorageRepositoryProvider);

    final int limit = state.isEmpty ?15:10;
    final movies = await localMovieRepository.loadFavoriteMovies(
      limit: limit,
      offset: page *10
    );
    page++;

    final tempMovies = <int,Movie>{};

    for(final movie in movies){
        //state = {...state, movie.id:movie};
        tempMovies[movie.id] = movie;
    }

    state = {...state,...tempMovies};
    return movies;
  }


  Future<void> toggleFavoriteMovie(Movie movie) async {

    final localStorageRepository = ref.read(localStorageRepositoryProvider);
    
    //Toma el repositorio para llamar a isFavoriteMovie del datasource 
    final bool isFavorite = await localStorageRepository.isFavoriteMovie(movie.id);
    // print('is favorite $isFavorite');
    await localStorageRepository.toggleFavoriteMovie(movie); //Agrega la movie en la db
    
    if (!ref.mounted) return;
    if(isFavorite){
      //Elimina el valor en el map con la key movie.id
      //Creamos un nuevo estado y lo asignamos al actual
      state = {...state}..remove(movie.id);
      return;
    }

    state = {...state, movie.id:movie};
  }
 

}
  
