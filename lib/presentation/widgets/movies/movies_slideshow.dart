import 'package:animate_do/animate_do.dart';
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
      height: 210,
      width: double.infinity,
      
      child: Swiper(
        viewportFraction: 0.8, //Espacio que cada slide ocupa verticalmemte solo ocupara 80% lo que deja cer 10 del lado izquierdo y 10 derecha
        scale: 0.9, //escala de los otros swipers que estan a los laterales
        autoplay: true, //efecto de carrusel 
        pagination: SwiperPagination( //Nos indican en que index nos encontramos, hay 3 tipos
          margin: EdgeInsets.only(top: 0), 
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary, //indicador
            color: colors.secondary //Color de los indicadores inactivos
          )
        ),
        itemCount:movies.length ,
        itemBuilder: (context, index) => _Slide(movie:movies[index]),
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
      borderRadius: BorderRadius.circular(20),
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

          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.backdropPath, //Carga la imagen
          fit: BoxFit.cover, //Toma el espacio que le otorgamos

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
      ),
    );
  }
}