import 'package:biblio_cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';


class HomeScreen extends StatelessWidget {

  static final name = 'home-screen'; //Nombre usado en router

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

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
                    loadNextPage: ()=>ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                    
                  ),

                  MovieHorizontalListview(
                    movies:popularMovies,
                    title: "Populares",
                    subTitle: "En este mes", 
                    loadNextPage: ()=>ref.read(popularMoviesProvider.notifier).loadNextPage(),
                    
                  ),
              
                  MovieHorizontalListview(
                    movies:nowPlayingMovies,
                    title: "Proximamente",
                    subTitle: "En este mes", 
                    loadNextPage: ()=>ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                    
                  ),

              
                  MovieHorizontalListview(
                    movies:nowPlayingMovies,
                    title: "Mejor calificadas",
                    subTitle: "Todos los tiempos", 
                    loadNextPage: ()=>ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                    
                  ),
              
                  SizedBox(height: 50,)
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





