import '../entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlayaing({int page = 1});
}
