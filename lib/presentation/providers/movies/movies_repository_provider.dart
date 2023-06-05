import 'package:cinema_app/infreastucture/datasouerces/moviedb_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infreastucture/repositories/movie_repository_impl.dart';

// solo de lectura
final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(MovieDbDataSource());
});
