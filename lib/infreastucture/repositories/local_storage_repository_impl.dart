import 'package:cinema_app/domain/datasources/local_storage_datasource.dart';
import 'package:cinema_app/domain/entities/movie.dart';

import '../../domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl({required this.dataSource});

  @override
  Future<bool> isMovieInFavorites(int movieId) {
    return dataSource.isMovieInFavorites(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return toggleFavorite(movie);
  }
}
