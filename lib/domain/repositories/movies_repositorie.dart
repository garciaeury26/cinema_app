import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlayaing({int page = 1});
}
