// import 'package:biblio_cine_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:biblio_cine_app/config/router/app_router.dart';
import 'package:biblio_cine_app/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Main envuelto en future para usar dotenv, variables de entorno
//https://pub.dev/packages/flutter_dotenv

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Eliminar datos de la db de driff
  //------------
  // final container = ProviderContainer();
  // final db = container.read(appDatabaseProvider);

  // final deletequery = db.delete(db.favoriteMovieTable);
  // await deletequery.go();
//-------------------
  await dotenv.load(fileName: '.env'); //damos la direccion de los env

  runApp(
    ProviderScope(
      //Opcion de reintentar cargar el provider si surge un error
      //retry: (retryCount, error) => null,
      child: MainApp()
    )
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter, //instancia de appRouterProvider
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
