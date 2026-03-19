import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:biblio_cine_app/presentation/screens/screens.dart';
import 'package:biblio_cine_app/presentation/views/views.dart';

part 'app_router.g.dart';

@riverpod 
GoRouter appRouter (Ref ref){ 

  return GoRouter(
    initialLocation: '/',
    routes: $appRoutes
  );
}

// Definición de la rama Home con sus subrutas con TypedGoRoute
@TypedStatefulShellRoute<HomeRoute>(
  branches: [

    //Rama de home
    TypedStatefulShellBranch<HomeBranchData>(
      routes: [
        TypedGoRoute<HomeViewRoute>(
          path: '/',
        )
      ]
    ),


    //Rama de Categorias
    TypedStatefulShellBranch<CategoriesBranchData>(
      routes: [
        TypedGoRoute<CategoriesViewRoute>(
          path: '/populares',
        )
      ]
    ),


    //Rama de Favoritos
    TypedStatefulShellBranch<FavoritesBranchData>(
      routes: [
        TypedGoRoute<FavoritesViewRoute>(
          path: '/favorites',
        )
      ]
    ),


  ]
)

//Scaffold principal de navegación
class HomeRoute extends StatefulShellRouteData{
  const HomeRoute();
  
  @override 
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell ) {
    return HomeScreen(navigationShell: navigationShell,);
  }
}


//Definición de ramas
class HomeBranchData extends StatefulShellBranchData { const HomeBranchData(); }
class FavoritesBranchData extends StatefulShellBranchData { const FavoritesBranchData(); }
class CategoriesBranchData extends StatefulShellBranchData { const CategoriesBranchData(); }

//Ruta independiente de detailScreen
@TypedGoRoute<DetailsRoute>(path: '/movie/:id')
class DetailsRoute extends GoRouteData with $DetailsRoute {
  final String id;

  const DetailsRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) => MovieScreen(movieId: id);
}

//Ruta de HomeView
class HomeViewRoute extends GoRouteData with $HomeViewRoute{
  const HomeViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeView() ;
  }
}
//Ruta de FavoritesRoute
class FavoritesViewRoute extends GoRouteData with $FavoritesViewRoute{
  const FavoritesViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FavoritesViews() ;
  }
}

//Ruta de Categorias
class CategoriesViewRoute extends GoRouteData with $CategoriesViewRoute{
  const CategoriesViewRoute();
 
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PopularView() ;
  }
}