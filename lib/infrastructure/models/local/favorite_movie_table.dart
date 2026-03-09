import 'package:drift/drift.dart';

//Tabla de la base de datos local
class FavoriteMovieTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get movieId => integer().named('movie_id')();
  TextColumn get backdropPath => text().named('backdrop_path')();
  TextColumn get originalTitle => text().named('original_title')();
  TextColumn get posterPath => text().named('poster_path')();
  TextColumn get title => text()();
  RealColumn get voteAverage => 
    real().named('vote_avegare').withDefault(const Constant(0.0))();

}

