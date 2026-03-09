
import 'package:biblio_cine_app/domain/datasources/local_storage_datasource.dart';
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/infrastructure/datasources/local/app_database.dart';
import 'package:drift/drift.dart' as drift;

//Implementación que querys a la base de datos local

class DriftDatasource extends LocalStorageDatasource{

  final AppDatabase database;

  DriftDatasource({required this.database});


  @override
  Future<bool> isFavoriteMovie(int movieId) async{

    //Construir query
    final query = database.select(database.favoriteMovieTable)..where(
      (table) => table.movieId.equals(movieId)
    );

    //Ejecutar el  query
    final favoriteMovie = await query.getSingleOrNull();


    //Retornar result
    return favoriteMovie != null;

  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0}) async {

    //Query con paginación 
    final query = database.select(database.favoriteMovieTable)
      ..limit(limit, offset: offset);

    //Ejecutar el query
    final favoriteMovieRows = await query.get();

    //Mapear los resultados del query proveniente de la local db a una entidad de dominio, retornando una List<Movie>
    final movies = favoriteMovieRows.map(
      (row) => Movie(
        adult: false, 
        backdropPath: row.backdropPath, 
        genreIds: const[], 
        id: row.movieId, 
        originalLanguage: '', 
        originalTitle: row.originalTitle, 
        overview: '', 
        popularity: 0, 
        posterPath: row.posterPath, 
        releaseDate: DateTime.now(), 
        title: row.title, 
        video: false, 
        voteAverage: row.voteAverage, 
        voteCount: 0
        )
    ).toList();


    return movies;
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie)async {

    final isFavorite = await isFavoriteMovie(movie.id);

    if(isFavorite){

      final deleteQuery = database.delete(database.favoriteMovieTable)
        ..where((table) => table.movieId.equals(movie.id));

      await deleteQuery.go();

      return;
    }

    await database.into(database.favoriteMovieTable)
      .insert(
        FavoriteMovieTableCompanion.insert(
          movieId: movie.id, 
          backdropPath: movie.backdropPath, 
          originalTitle: movie.originalTitle, 
          posterPath: movie.posterPath, 
          title: movie.title,
          voteAverage: drift.Value(movie.voteAverage) //castear el valor
        )
      );

  }
}