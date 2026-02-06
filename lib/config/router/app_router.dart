import 'package:biblio_cine_app/presentation/screens/screens.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod  
GoRouter appRouter (Ref ref){

  return GoRouter(
    initialLocation: '/',
    routes: $appRoutes
  );
}

// Definición de la rama Home con sus subrutas con TypedGoRoute
@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<DetailsRoute>(path: 'details/:id'),
  ]
)

class HomeRoute extends GoRouteData with $HomeRoute{

  @override 
  Widget build(BuildContext context, GoRouterState state) =>HomeScreen();
}


class DetailsRoute extends GoRouteData with $DetailsRoute {
  final String id;

  const DetailsRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) => MovieScreen(movieId: id);
}