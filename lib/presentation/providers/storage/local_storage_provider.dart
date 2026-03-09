

import 'package:biblio_cine_app/domain/repositories/local_storage_repository.dart';
import 'package:biblio_cine_app/infrastructure/datasources/local/app_database.dart';
import 'package:biblio_cine_app/infrastructure/datasources/local/drift_datasource.dart';
import 'package:biblio_cine_app/infrastructure/repositories/local_storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_storage_provider.g.dart';

// Unica Instancia del AppDataBase
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

@Riverpod(keepAlive: true)
LocalStorageRepository localStorageRepository(Ref ref) {
  // Unica instancia de la DB
  final db = ref.watch(appDatabaseProvider);
  
  // Se lo pasamos al datasource
  return LocalStorageRepositoryImp(
    datasource: DriftDatasource(database: db)
  );
}