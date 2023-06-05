import 'package:cinema_app/domain/datasources/movies_datasouerces.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/infreastucture/mappers/movie_mapper.dart';
import 'package:cinema_app/infreastucture/models/movieDb/movie_db_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/enviroments.dart';

class MovieDbDataSource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    queryParameters: {'api_key': Enviroment.movieDbKey, 'lenguage': 'es-MX'},
    baseUrl: 'https://api.themoviedb.org/3/',
  ));

  @override
  Future<List<Movie>> getNowPlayaing({int page = 1}) async {
    final response = await dio.get('movie/now_playing');
    final List<Movie> movies = MovieDbResponse.fromJson(response.data)
        .results
        .where((movieDb) => movieDb.backdropPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();

    return movies;
  }
}
