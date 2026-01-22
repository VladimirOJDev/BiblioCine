import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_providers.g.dart';

enum MovieCategory{
  nowPlaying,popular,upcoming,topRated

}

@riverpod
class Movies extends _$Movies{

  int currentPage = 0;
  bool isLoading = false;

  @override
  List<Movie> build(MovieCategory category){
    return [];
  }

  Future<void> loadNextPage()async{

    if(isLoading)return; // cuando carga no retorna mas peticiones

    isLoading = true;
    
    currentPage++;

    final repository = ref.read(movieRepositoryProvider);

    final movies =  await switch(category){
      MovieCategory.nowPlaying => repository.getNowPlaying(page: currentPage),
      MovieCategory.popular => repository.getPopular(page: currentPage),
      MovieCategory.upcoming => repository.getUpcoming(page: currentPage),
      MovieCategory.topRated => repository.getTopRated(page: currentPage),
    };

    state = [...state, ...movies];
    await Future.delayed(const Duration(microseconds: 300));//Pausa para renderizar
    isLoading = false;
  }
}
