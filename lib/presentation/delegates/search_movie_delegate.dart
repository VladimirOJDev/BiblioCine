import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:biblio_cine_app/config/helpers/human_formats.dart';
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';

//definimos un tipo de dato para poder pasar la funcion de busqeuda
//de peliculas desde el repositoriprovider
typedef SearchMoviesCallback = Future<List<Movie>> Function (String query);


//El delegado de busqueda, se encarga de hacer una pantalla de busqueda
class SearchMovieDelegate extends SearchDelegate<Movie?>{

  final SearchMoviesCallback searchMovies; 
  List<Movie> initialMovies; //Listado de depliclas previamente cargadas


  //Debounced, para mandar peticiones cada cierto tiempo y no cada ves que escriba el usuario
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast(); //emite valores
  Timer? _debounceTimer;

  SearchMovieDelegate({

    required this.initialMovies, 
    required this.searchMovies
  });

  //Función que elimina los streams creados y guardados en caché
  //Se llama cuando se cierra el searchDelegate
  void clearStreams(){
    debouncedMovies.close();
  }

  //Función que hace el retardo de la petición
  void _onQueryChanged(String query){

    //si el timer esta actrivo no cancela el timer
    if(_debounceTimer?.isActive ?? false){
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async{
      
      //No realiza la petición si el query está vacío 


      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
      initialMovies = movies;
    });
  }

  //Letras del field, desaparece cuando escribes
  @override 
  String get searchFieldLabel =>"Buscar pelicula";

  //Icono derecho que borra la query
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //Cuando se preciona limpia el campo de busqueda cuando no esta vacía
      if(query.isNotEmpty)

        FadeIn(
          duration: Duration(milliseconds: 200),
           //query es palabra reservada del SearchDelegate por defecto 
          child: IconButton(onPressed: () => query ='', icon: Icon(Icons.clear)),
        )
        
    ];
  }

  Widget buildResultsAndSuggestions(){

    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context,snapshot){

        
        final movies = snapshot.data??[];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            
            return _MovieSearchItem(
              movie: movie,
              onMovieSelected:(context,movie){
                clearStreams();
                close(context,movie);
              } , //Close es una propiedad del delegate
            );
          },
        );
      }
    );
  }
  
  //Icono que nos regresa a la pantalla anterioir
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      clearStreams();
      close(context, null);
    },

      icon: Icon(Icons.arrow_back_ios_new_outlined)
    );
  }

  //Función de búsqueda cuando el usuario da enter
  @override
  Widget buildResults(BuildContext context) {

    return buildResultsAndSuggestions();
  }

//Función de búsqueda
  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}


//Peliculas en la bsuqeuda

class _MovieSearchItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieSearchItem({ required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context,movie);
      },
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            
            //image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.network(movie.posterPath),
              ),
            ),
      
            SizedBox(width: 10,),
            
            //Description
            SizedBox(
              width: size.width* 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium,),
      
                  (movie.overview.length>100)
                  ?Text('${movie.overview.substring(0,81)}...',textAlign:TextAlign.left ,)
                  :Text(movie.overview),
      
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                      SizedBox(width: 5,),
                      Text(HumanFormats.number(movie.voteAverage,2),style:textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}