import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:biblio_cine_app/infrastructure/models/local/favorite_movie_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [FavoriteMovieTable])
class AppDatabase extends _$AppDatabase {

  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'favorites_movie_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),

    );
  }
}

