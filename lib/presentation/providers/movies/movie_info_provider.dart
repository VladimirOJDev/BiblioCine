import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_info_provider.g.dart';

@riverpod 
class MovieInfo extends _$MovieInfo{
  
  @override
  Map<String, Movie> build() {
    // Este es tu super({}) original. 
    // Al ser un mapa de caché, iniciamos con un mapa vacío.
    return {};
  }

  Future<void> loadMovie(String movieId) async {
    // 1. Verificamos si ya está en el caché (tu lógica original)
    if (state[movieId] != null) return;

    // 2. Obtenemos el repositorio directamente usando ref
    final repository = ref.read(movieRepositoryProvider);

    // 3. Realizamos la petición
    final movie = await repository.getMovieById(movieId);

    // 4. Actualizamos el estado creando un nuevo mapa con el nuevo valor
    state = {...state, movieId: movie};
  }
}
