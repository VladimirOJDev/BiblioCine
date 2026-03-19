import 'package:biblio_cine_app/config/router/app_router.dart';
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;
  const MoviePosterLink({super.key, required this.movie});

@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DetailsRoute(id: movie.id.toString()).push(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        // AspectRatio: Crucial para que el Grid sepa el tamaño ANTES de cargar la imagen
        child: AspectRatio(
          aspectRatio: 2 / 3, // Proporción estándar de posters de cine
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover, // Asegura que la imagen llene el espacio
            // 2. LoadingBuilder: Evita que el espacio esté vacío (altura 0) mientras carga
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.black12, // Placeholder grisáceo
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              );
            },
            // ErrorBuilder: Si la imagen falla, que no rompa el diseño
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.black87,
                child: const Icon(Icons.error, color: Colors.white24),
              );
            },
          ),
        ),
      ),
    );
  }

}