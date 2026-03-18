import 'package:animate_do/animate_do.dart';
import 'package:biblio_cine_app/config/router/app_router.dart' show DetailsRoute;
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {

  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});


  @override
  Widget build(BuildContext context) {
    
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 230,
      width: double.infinity,
      
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Swiper(
          viewportFraction: 1, //Espacio que cada slide ocupa verticalmemte solo ocupara 80% lo que deja 10 del lado izquierdo y 10 derecha
          scale: 1, //escala de los otros swipers que estan a los laterales
          autoplay: true, //efecto de carrusel 
          autoplayDelay: 7000,//transición mas lenta
        
          pagination: SwiperPagination( //Nos indican en que index nos encontramos, hay 3 tipos
            margin: EdgeInsets.only(top: 0), 
            builder: DotSwiperPaginationBuilder(
              activeColor: colors.primary, //indicador
              color: colors.secondary, //Color de los indicadores inactivos
              size: 10,
              activeSize: 14
            )
          ),
        
          itemCount:movies.length ,
          itemBuilder: (context, index) => RepaintBoundary(child: _Slide(movie:movies[index])),
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {


    final decoration  = BoxDecoration( // Tipo de dato que requiere DecoratedBox
      borderRadius: BorderRadius.circular(1),
      boxShadow: [

        BoxShadow(                    
          color: Colors.black45,
          blurRadius: 10, //difuminado
          offset: Offset(0, 10)
        )
      ],
    );



    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 30),

      //DecoratedBox widget que permite dibujar una decoración detrás de su child
      child: DecoratedBox(  
        decoration: decoration,
        child: ClipRRect(

          borderRadius: BorderRadius.circular(1),

          child: GestureDetector(
            onTap: ()=> DetailsRoute(id: movie.id.toString()).push(context),
            child: Stack(
              children: [
                Positioned.fill(
            
                  child: Image.network(
                    movie.backdropPath, //Carga la imagen
                    fit: BoxFit.cover, //Toma el espacio que le otorgamos
                    cacheHeight: 400, // Reedimenciona la imagen descargada de la red para hacerla mas lijera
                    loadingBuilder: (context, child, loadingProgress) { //progreso de la carga
                      if(loadingProgress != null ){
                        return const DecoratedBox(
                           decoration: BoxDecoration(
                            color: Colors.black12
                          ),
                         );
                      }
                      return FadeIn(child: child); //retorna el child normal del  ClipRRect con un efecto de fade
                    }, 
                  ),
                ),
            
                // Overlay oscuro en la parte inferior
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color.fromARGB(132, 24, 21, 21),
                        ],
                      ),
                    ),
                  ),
                ),
            
            
                //Titulo de la peli
                Positioned(
                  bottom: 15,
                  left: 15,
                  right: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                         color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
            
                      //Calificación 
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 5),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}