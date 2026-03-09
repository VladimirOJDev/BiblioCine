import 'package:animate_do/animate_do.dart';
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/presentation/providers/storage/favorites_movies_providers.dart';
import 'package:biblio_cine_app/presentation/providers/storage/is_favorite_movie.dart';
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

    if (movie == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CustomScrollView(
        //Este widget solo acepta widgets detipo Sliver
        physics: ClampingScrollPhysics(), // animación de rebote
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(8),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath, width: size.width * 0.3),
              ),

              const SizedBox(width: 10),

              //Titulo y descripción
              SizedBox(
                width: (size.width - 40) * 0.70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      movie.title,
                      style: textStyles.titleLarge,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10),
                    Text(movie.overview, textAlign: TextAlign.justify),
                  ],
                ),
              ),
            ],
          ),
        ),

        //Generos de la pelicula
        Padding(
          padding: EdgeInsetsGeometry.all(8),

          // wrap nos da organización de múltiples elementos dentro de un espacio
          //y da un salto de linea cuando no hay ams espacio en el padre.
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (gender) => Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(gender, style: TextStyle(color: Colors.black)),

                    side: BorderSide(color: Colors.black26, width: 1.5),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //Mostrar los actores
        _ActorsByMovie(movieId: movie.id.toString()),
        SizedBox(height: 50),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator();
    }

    final actors = actorsByMovie[movieId];

    return SizedBox(
      height: 300,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors!.length,
        itemBuilder: (context, index) {
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
                const SizedBox(height: 5),

                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? "",
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//AppBar flexible con gradiente y posterpath
class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size; //Tamaño de la pantalla
    final isFavorite = ref.watch(isFavoriteMovieProvider(movie.id));

    return SliverAppBar(

      actions: [
        IconButton(
          onPressed: () async{

            //Actualiza la db y el mapa
            await ref.read(favoritesMoviesProvider.notifier)
              .toggleFavoriteMovie(movie);
              
            ref.invalidate(isFavoriteMovieProvider(movie.id));
          },
          //icon: Icon(Icons.favorite_border_outlined))
          //icon: Icon(Icons.favorite, color: Colors.red),
          icon: isFavorite.when(
            data: (isfavorite) => 
              isfavorite? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border_outlined), 

            error:(error, stackTrace) => throw Exception('Error al cargar favorito'), 
            loading: ()=> const CircularProgressIndicator(strokeWidth: 2)
          ),
        ),
      ],
      centerTitle: false,
      backgroundColor: Colors.black, //Color de fondo
      //surfaceTintColor: Colors.transparent, //elimina el efecto de blur por defecto
      expandedHeight: size.height * 0.7, //Espacio que ocupa el appBar
      foregroundColor: Colors.white, //Color del contenido (terxto,iconos,etxc.)

      flexibleSpace: FlexibleSpaceBar(
        //Contenido flexible, crece, se comprime etc. depende de la configuración

        // title: Text(
        //   movie.title,
        //   style: const TextStyle(color: Colors.white, fontSize:20),
        //   textAlign: TextAlign.start,
        // ),
        titlePadding: const EdgeInsetsDirectional.only(
          start: 10, // Ajusta este número (0 para pegarlo totalmente)
          bottom: 20, // Espacio respecto a la parte inferior
        ),

        background: Stack(
          children: [
            // Usamos Positioned.fill para que la imagen ignore cualquier padding
            Positioned.fill(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),

            //Gradiente
            _CustomGradient(
              begin:AlignmentGeometry.topCenter ,
              end:Alignment.bottomCenter ,
              stops: [0.7, 1.0],
              colors:  [Colors.transparent, Colors.black],
            ),

            //sombra del botón de favoritos
            _CustomGradient(
              begin:Alignment.topRight ,
              end:Alignment.bottomRight ,
              stops: [0.0, 0.3],
              colors:  [Colors.black, Colors.transparent],
            ),


            //Gradiente arriba para visivilizar el boton de regreso
            _CustomGradient(
              begin:AlignmentGeometry.topLeft ,
              end:Alignment.bottomCenter ,
              stops: [0.0, 0.2],
              colors: [Colors.black87, Colors.transparent],
            ),

          ],
        ),
      ),
    );
  }
}

//Gradiente reutilizable
class _CustomGradient extends StatelessWidget {
  
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;


  const _CustomGradient({
     required this.begin,
     required this.end, 
     required this.stops,
     required this.colors,
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      //expand ocupa todo el espacio del padre
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
