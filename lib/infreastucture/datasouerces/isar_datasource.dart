import 'package:cinema_app/domain/entities/movie.dart';

import '../../domain/datasources/local_storage_datasource.dart';

class IsarDataSource extends LocalStorageDataSource {
  @override
  Future<void> toggleFavorite(Movie movie) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isMovieInFavorites(int movieId) {
    // TODO: implement isMovieInFavorites
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }
}
