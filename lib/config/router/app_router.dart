

import 'package:biblio_cine_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      //Rutas anidadas o child route
      routes: [
        GoRoute(
            path: 'movie/:id', //Manda el argumento id string
            name: MovieScreen.name,
            builder: (context, state){
              //Acceso a parámetros de ruta (Path Parameters) 'id'
              final movieId = state.pathParameters['id']?? ' no id';

              return MovieScreen(movieId: movieId,); //Pasa el argumento por parametro
          }
        ),
      ]
    ),

  ]
);