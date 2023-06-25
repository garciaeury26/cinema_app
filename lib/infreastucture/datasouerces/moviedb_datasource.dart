import 'package:cinema_app/domain/datasources/movies_datasouerces.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/infreastucture/mappers/movie_mapper.dart';
import 'package:cinema_app/infreastucture/models/movieDb/movie_db_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/enviroments.dart';
import '../models/movieDb/moview_details.dart';

class MovieDbDataSource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    queryParameters: {'api_key': Enviroment.movieDbKey, 'lenguage': 'es-MX'},
    baseUrl: 'https://api.themoviedb.org/3/',
  ));

  @override
  Future<List<Movie>> getNowPlayaing({int page = 1}) async {
    final response =
        await dio.get('movie/now_playing', queryParameters: {'page': page});
    final List<Movie> movies = MovieDbResponse.fromJson(response.data)
        .results
        .where((movieDb) => movieDb.backdropPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('movie/popular', queryParameters: {'page': page});
    final movies = fromJsonToMovies(response.data);

    return movies;
  }

  List<Movie> fromJsonToMovies(Map<String, dynamic> json) {
    return MovieDbResponse.fromJson(json)
        .results
        .where((movieDb) => movieDb.backdropPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();
  }

  @override
  Future<List<Movie>> getTop({int page = 1}) async {
    final response =
        await dio.get('movie/top_rated', queryParameters: {'page': page});
    final movies = fromJsonToMovies(response.data);
    return movies;
  }

  @override
  Future<List<Movie>> getUpCuming({int page = 1}) async {
    final response =
        await dio.get('movie/upcoming', queryParameters: {'page': page});
    final movies = fromJsonToMovies(response.data);
    return movies;
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('movie/$id');

    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final movieDb = MovieDetailsResponse.fromJson(response.data);
    final movies = MovieMapper.movieDetailsToEntity(movieDb);
    return movies;
  }
}
