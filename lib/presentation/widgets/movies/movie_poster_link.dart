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
        child: Image.network(movie.posterPath),
      ),
    );
  }
}