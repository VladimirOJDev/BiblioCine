import 'package:biblio_cine_app/presentation/providers/movies/movies_providers.dart';
import 'package:biblio_cine_app/presentation/widgets/movies/movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}

class PopularViewState extends ConsumerState<PopularView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context ) {
    super.build(context);
    
    final popularMovies = ref.watch(moviesProvider(MovieCategory.popular));
    
    if ( popularMovies.isEmpty ) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Películas Populares"),
      ),
      body: MoviesMasonry(
        loadNextPage: () => ref.read(moviesProvider(MovieCategory.popular).notifier).loadNextPage(),
        // ref.read(moviesProvider(MovieCategory.popular).notifier).loadNextPage(),
        movies: popularMovies
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
