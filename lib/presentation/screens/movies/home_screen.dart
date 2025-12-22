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
  }

  @override
  Widget build(BuildContext context) {

    //final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    if(nowPlayingMovies.isEmpty) return Center(child: CircularProgressIndicator());

    return Column(
      children: [

        //AppBar genérico
        CustomAppbar(),

        //Dado el padre expande todo lo que pueda
        MoviesSlideshow(movies: slideShowMovies),

        //Scroll horizontal infinito de peliculas
        MovieHorizontalListview(
          movies:nowPlayingMovies,
          title: "En cines",
          subTitle: "Lunes", 
          loadNextPage: ()=>ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          
        ),
      ],
    );
  }
}