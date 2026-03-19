import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/presentation/widgets/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';



class MoviesMasonry extends StatefulWidget {

  final List<Movie> movies;
  //final Future<List<Movie>> Function()? loadNextPage;
  final VoidCallback? loadNextPage;

  const MoviesMasonry({
    super.key, 
    required this.movies, 
    this.loadNextPage
  });

  @override
  State<MoviesMasonry> createState() => _MoviesMasonryState();
}

class _MoviesMasonryState extends State<MoviesMasonry> {
  bool isLastPage = false;
  bool isLoading = false;
  final scrollController = ScrollController() ;


  @override
  void initState() {
    super.initState();

    //Inicializar los primeros 10 favoritos
    scrollController.addListener((){
        if(widget.loadNextPage == null)return;

        //Si el scroll está cerca de 200px del fondo, llamar loadnextpage
        if(scrollController.position.pixels+200 >= scrollController.position.maxScrollExtent){
          widget.loadNextPage!();
        }
      }
    );
    
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      child: MasonryGridView.count(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 3, 
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder:(context, index){
          
          //Desface en la segunda columna
          if(index==1){
            return Column(
              children: [
                const SizedBox(height: 30,),
                MoviePosterLink(movie: widget.movies[index])
              ],
            );
          }
          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}


