import 'package:animate_do/animate_do.dart';
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static final name = 'movie-screen'; //Nombre usado en router

  final String movieId; 
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {

    //recupera el mapa Map<String,Movie> y con el widget.modieId recupera la Movie
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    
    if(movie==null){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(//Este widget solo acepta widgets detipo Sliver
        physics: ClampingScrollPhysics(),// animación de rebote 
        slivers: [
          _CustomSliverAppBar(movie: movie,),
         SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index)=>_MovieDetails(movie: movie,),
              childCount: 1
            ),
            
          )

        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {

  final Movie movie;

  const _MovieDetails({ required this.movie});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsetsGeometry.all(8),

          child:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10,),

              //Titulo y descripción
              SizedBox(
                width: (size.width-40 )* 0.70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  
                  children: [
                    Text(
                      movie.title,
                      style:textStyles.titleLarge,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10,),
                    Text(movie.overview,textAlign: TextAlign.justify,)
                  ],
                ),
              )
            ],
          ) ,
        ),

        //Generos de la pelicula
        Padding(
          padding: EdgeInsetsGeometry.all(8),

          // wrap nos da organización de múltiples elementos dentro de un espacio 
          //y da un salto de linea cuando no hay ams espacio en el padre.
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) =>Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(

                  label: Text(gender,
                    style: TextStyle(color: Colors.black),
                  ),

                  side: BorderSide(
                    color: Colors.black26,
                    width: 1.5,
                  ),

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ) ,)
            ],
          ),
        ),

        //Mostrar los actores
        _ActorsByMovie(movieId: movie.id.toString()),
        SizedBox(height: 50,)
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {

  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if(actorsByMovie[movieId] == null){
      return const CircularProgressIndicator();
    }

    final actors = actorsByMovie[movieId];

    return SizedBox(
      height: 300,

      child: ListView.builder(
        scrollDirection:Axis.horizontal ,
        itemCount: actors!.length,
        itemBuilder: (context, index){
          final actor = actors[index];

          return Container(
            padding: EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Actor photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //Actor name
                const SizedBox(height: 5,),

                Text(actor.name, maxLines: 2,),
                Text(
                  actor.character ?? "",
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis) ,
                )
              ],
            ),
          );
        }
      ),
    );
  }
}

//AppBar flexible con gradiente y posterpath
class _CustomSliverAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size; //Tamaño de la pantalla

    return SliverAppBar(
      
      centerTitle: false,
      backgroundColor: Colors.black,//Color de fondo
      //surfaceTintColor: Colors.transparent, //elimina el efecto de blur por defecto
      expandedHeight: size.height *0.7,//Espacio que ocupa el appBar
      foregroundColor: Colors.white, //Color del contenido (terxto,iconos,etxc.)

      flexibleSpace:FlexibleSpaceBar( //Contenido flexible, crece, se comprime etc. depende de la configuración  
        
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(color: Colors.white, fontSize:20),
        //   textAlign: TextAlign.start,
        // ),

        titlePadding: const EdgeInsetsDirectional.only(
          start: 10, // Ajusta este número (0 para pegarlo totalmente)
          bottom: 20, // Espacio respecto a la parte inferior
        ),

        background:Stack(
          children: [

            // Usamos Positioned.fill para que la imagen ignore cualquier padding
            Positioned.fill(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null)return const SizedBox();
                  return FadeIn(child: child);
                }, 
              ),
            ),

            //Gradiente
            SizedBox.expand( //expand ocupa todo el espacio del padre
              child: DecoratedBox(
                decoration:BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7,1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black
                    ]
                  )
                ) ,
              ),
            ),

            //Gradiente arriba para visivilizar el boton de regreso
            SizedBox.expand( //expand ocupa todo el espacio del padre
              child: DecoratedBox(
                decoration:BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topLeft,
                    end: Alignment.bottomCenter,
                    stops: [0.0,0.2],
                    colors: [
                      Colors.black87,
                      Colors.transparent
                    ]
                  )
                ) ,
              ),
            )
          ],
        ) ,
          
      ),

      
    );
  }
}



