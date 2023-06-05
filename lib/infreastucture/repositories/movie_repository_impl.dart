import 'package:cinema_app/domain/datasources/movies_datasouerces.dart';
import 'package:cinema_app/domain/repositories/movies_repositorie.dart';

import '../../domain/entities/movie.dart';

class MoviesRepositoryImpl extends MovieRepository {
  final MoviesDatasource datasource;

  MoviesRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlayaing({int page = 1}) {
    return datasource.getNowPlayaing();
  }
}
