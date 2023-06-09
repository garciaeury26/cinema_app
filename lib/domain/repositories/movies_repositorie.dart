import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlayaing({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTop({int page = 1});
  Future<List<Movie>> getUpCuming({int page = 1});
  Future<Movie> getMovieById(String id);
  Future<List<Movie>> searchMovie(String query);
}
