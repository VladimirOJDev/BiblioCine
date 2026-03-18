import 'package:animate_do/animate_do.dart';
import 'package:biblio_cine_app/config/router/app_router.dart';
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';


class MovieHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key, 
    required this.movies, 
    this.title, this.subTitle,
    this.loadNextPage
  });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener((){ //Cada que se cree hay que crear un dispose para limpiar cuando salga
      if(widget.loadNextPage == null)return;

      //Condicion que asocia si se llega al pixel maximo del scroll
      if(scrollController.position.pixels+200 >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!(); //Aseguramos con ! que no será null
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Column(
        children: [
          if(widget.title!=null || widget.subTitle!=null)

          //Titulo del listview (en cines, populares etc.)
          _Title(title:widget.title,subTitle:widget.subTitle),

          //Películas
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6), 
                    child: _Slide2(movie: widget.movies[index])
                  )
                );
              },
            ),
          )

        ],
      ),
    );
  }
}

class _Slide2 extends StatelessWidget {

  final Movie movie;

  const _Slide2({ required this.movie });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Poster 
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: GestureDetector(
              onTap: ()=> DetailsRoute(id: movie.id.toString()).push(context),
              child: AspectRatio(
                aspectRatio: 2 / 3, // evita overflow y mantiene proporción real
                child: Stack(
                  children: [
              
                    // Imagen optimizada
                    Image.network(
                      movie.posterPath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      cacheWidth: 300,
                      loadingBuilder: (context, child, progress) {
                        if (progress != null) {
                          return Container(color: Colors.grey[300]);
                        }
                        return FadeIn(child: child); 
                      },
                    ),
              
                    // Gradient ligero
                    const Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [
                              Colors.black45,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
              
                    // Rating sobre imagen 
                    Positioned(
                      bottom: 6,
                      left: 6,
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber.shade700),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: textStyle.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Title (limitado para no romper layout)
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textStyle.bodyMedium,
          ),
        ],
      ),
    );
  }
}


class _Title extends StatelessWidget {

  final String? title;
  final String? subTitle;

  const _Title({this.title,this.subTitle});

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10,),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          if(title!=null)
            Text(title!, style: titleStyle,),

          const Spacer(),

          if(subTitle!=null)
            FilledButton.tonal(
              style: ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {
              }, 
              child: Text(subTitle!)
            )
        ],
      ),
    );
  }
}