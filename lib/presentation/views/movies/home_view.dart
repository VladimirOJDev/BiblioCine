
import 'package:biblio_cine_app/presentation/providers/movies/initial_loading_provider.dart';
import 'package:biblio_cine_app/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../providers/movies/movies_providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read(moviesProvider(MovieCategory.nowPlaying).notifier).loadNextPage();
    ref.read(moviesProvider(MovieCategory.popular).notifier).loadNextPage();
    ref.read(moviesProvider(MovieCategory.upcoming).notifier).loadNextPage();
    ref.read(moviesProvider(MovieCategory.topRated).notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {

    
    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return FullScreenLoader();

    final nowPlayingMovies = ref.watch(moviesProvider(MovieCategory.nowPlaying));
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    //final popularMovies = ref.watch(moviesProvider(MovieCategory.popular));
    final upcomingMovies = ref.watch(moviesProvider(MovieCategory.upcoming));
    final topRatedMovies = ref.watch(moviesProvider(MovieCategory.topRated));

    if(nowPlayingMovies.isEmpty) return Center(child: CircularProgressIndicator());

    //return SingleChildScrollView()
    return CustomScrollView( //Widget para crear efectos de scroll

      //Dentro de la lista solo tienen que haber Slivers a su vez estos pueden contener otos wodgets
      slivers: [

        ///Appbar que reacciona al scroll
        const SliverAppBar(
          
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: CustomAppbar(),
            
          ),
          
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context,index){
              return  Column(
                children: [
             
                  //Dado el padre expande todo lo que pueda
                  MoviesSlideshow(movies: slideShowMovies),
              
                  //Scroll horizontal infinito de peliculas en cines
                  MovieHorizontalListview(
                    movies:nowPlayingMovies,
                    title: "En cines",
                    subTitle: "Lunes", 
                    loadNextPage: ()=> ref.read(moviesProvider(MovieCategory.nowPlaying).notifier).loadNextPage(),
                    
                  ),

                  // MovieHorizontalListview(
                  //   movies:popularMovies,
                  //   title: "Populares",
                  //   subTitle: "En este mes", 
                  //   loadNextPage: ()=>ref.read(moviesProvider(MovieCategory.popular).notifier).loadNextPage(),
                    
                  // ),
              
                  MovieHorizontalListview(
                    movies:upcomingMovies,
                    title: "Proximamente",
                    subTitle: "En este mes", 
                    loadNextPage: ()=> ref.read(moviesProvider(MovieCategory.upcoming).notifier).loadNextPage(),
                    
                  ),

              
                  MovieHorizontalListview(
                    movies:topRatedMovies,
                    title: "Mejor calificadas",
                    subTitle: "Todos los tiempos", 
                    loadNextPage: ()=> ref.read(moviesProvider(MovieCategory.topRated).notifier).loadNextPage(),
                    
                  ),
              
                  SizedBox(height: 30,)
                ],
              );

            },
            childCount: 1
          )
        )
      ],
    );  
    
  }
}





