import 'package:cinema_app/domain/datasources/movies_datasouerces.dart';
import 'package:cinema_app/domain/repositories/movies_repositorie.dart';

import '../../domain/entities/movie.dart';

class MoviesRepositoryImpl extends MovieRepository {
  final MoviesDatasource datasource;

  MoviesRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlayaing({int page = 1}) {
    return datasource.getNowPlayaing(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTop({int page = 1}) {
    return datasource.getTop(page: page);
  }

  @override
  Future<List<Movie>> getUpCuming({int page = 1}) {
    return datasource.getUpCuming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovie(String query) {
    return datasource.searchMovie(query);
  }
}
