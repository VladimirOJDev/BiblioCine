import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/presentation/delegates/search_movie_delegate.dart';
import 'package:biblio_cine_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:biblio_cine_app/config/router/app_router.dart';


class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;


    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10 ),
        child: SizedBox(
          width: double.infinity, //ancho, que pueda tomar hasta donde pueda
          child: Row(
            children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary,),
              SizedBox(width: 5,),
              Text("BiblioCine", style: titleStyle,),
              Spacer(), //Toma todo el espacio posible

              IconButton(
                onPressed: () async{
                  
                  final searchMovies = ref.read(searchMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);

                  final movie = await showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                     
                      initialMovies:searchMovies ,//estado del provider
                      searchMovies: ref.read(searchMoviesProvider.notifier).searchMoviesByQuery
                    )
                  );
                  //Si no hay película, no hacemos nada
                  if(movie == null)return;

                  //Verificamos si el context sigue siendo válido (si el widget está montado)
                  if (!context.mounted) return;
                  
                  DetailsRoute(id: movie.id.toString()).go(context);
                  //context.push("/movie/${movie.id}");
                },

                icon: Icon(Icons.search)
              ),

            ],
          ),
        ),
      ),
    );
  }
}