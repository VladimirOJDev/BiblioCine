import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_movies_providers.g.dart';

@Riverpod(keepAlive: true)
class SearchQuery extends _$SearchQuery {
  @override
  String build() {
    return ''; //  estado inicial
  }

  // método para cambiar el valor
  void updateQuery(String newQuery) {
    state = newQuery;
  }
} 


@Riverpod(keepAlive: true)
class SearchMovies extends _$SearchMovies {
  @override
  List<Movie> build() {
    return []; //  estado inicial
  }

  Future<List<Movie>> searchMoviesByQuery(String query) async{

    final repository = ref.read(movieRepositoryProvider);
    ref.read(searchQueryProvider.notifier).updateQuery(query);

    final List<Movie> movies = await repository.searchMovies(query);
    state = movies;
    return movies;
  }

} 
