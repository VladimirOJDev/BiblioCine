import 'package:biblio_cine_app/config/constans/environment.dart';
import 'package:biblio_cine_app/domain/datasources/movies_datasource.dart';
import 'package:biblio_cine_app/domain/entities/movie.dart';
import 'package:biblio_cine_app/infraestructure/mappers/movie_mapper.dart';
import 'package:biblio_cine_app/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource{
  
  //Url http con dio 
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    queryParameters: {
      'api_key':Environment.movieDbKey,
      'language': 'es-MX'
    }
  ));

  List<Movie> _jsonToMovies(Map<String,dynamic> json){
    
    //De la respuesta json lo convierte a un modelo de datos de la infraestructura
    final movieDBResponse = MovieDbResponse.fromJson(json);

    /**
     * Lista de Movies
     * 
     * De MovieDBResponse.results, es la parte donde vienen unicamente las peliculas 
     * donde nosotros guardamos los json en una  List<MovieMovieDB> ('results':List<MovieMovieDB>)
     * mapeamos cada película en este caso le llamamos a la variable movieDB
     * a un Movie que es una entidad de dominio y lo convertimos a una lista
     */

    final List<Movie> movies = movieDBResponse.results
    .where((movieDB) => movieDB.posterPath !=  'no-poster',) //Filtradopor poster, si no tiene, la pelicula no se agrega a la list
    .map((movieDB) => 
      MovieMapper.movieDBToEntity(movieDB)
    ).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{


    final response = await dio.get('/movie/now_playing',
      queryParameters: {'page':page}
    );

    //response.data; //datos tipo json
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    
    final response = await dio.get('/movie/popular',
      queryParameters: {'page':page}
    );
    //Conversion de json a un modelo de datos local
    return _jsonToMovies(response.data);   
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {

    final response = await dio.get('/movie/upcoming',
    queryParameters: {'page':page}
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async{
    final response = await dio.get('/movie/top_rated',
    queryParameters: {'page':page}
    );

    return _jsonToMovies(response.data);
  }

}