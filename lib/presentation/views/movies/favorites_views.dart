import 'package:biblio_cine_app/presentation/providers/storage/favorites_movies_providers.dart';
import 'package:biblio_cine_app/presentation/widgets/movies/movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesViews extends ConsumerStatefulWidget {
  const FavoritesViews({super.key});

  @override
  ConsumerState<FavoritesViews> createState() => _FavoritesViewsState();
}

class _FavoritesViewsState extends ConsumerState<FavoritesViews> {

  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
  
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {

    if ( isLoading || isLastPage ) return;
    isLoading = true;

    final movies = await ref.read(favoritesMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if ( movies.isEmpty ) {
      isLastPage = true;
    }

  }

  @override
  Widget build(BuildContext context) {

    final favoriteMovies =   ref.watch(favoritesMoviesProvider);
    final movieList = favoriteMovies.values.toList();

    final colorPrimary = Theme.of(context).colorScheme.primary;

    //Cargar cuando no hay peliculas 
    if(favoriteMovies.isEmpty){
      return Scaffold(
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 100,color:colorPrimary,),
              Text("Aún no tienes películas favoritas")
            ],
          )

        )
      );
      
    }
   
    //Cargar cuando hay peliculas
    return Scaffold(
        appBar: AppBar(
          title: Text("Tus Favoritos"),
        ),
      body:Column(
        children: [
          Expanded(
            child: MoviesMasonry(
              movies: movieList,
              loadNextPage:loadNextPage,
            ),
          ),
        ],
      )
    );
  }
}