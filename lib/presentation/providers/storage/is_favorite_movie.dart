
import 'package:biblio_cine_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_favorite_movie.g.dart';

@riverpod
Future<bool> isFavoriteMovie(Ref ref, int movieId) {
  // Observamos el mapa de favoritos que existe
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  
  // Si el mapa contiene la llave, devolvemos true
  return localStorageRepository.isFavoriteMovie(movieId);
}