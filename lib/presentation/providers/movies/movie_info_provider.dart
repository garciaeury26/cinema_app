import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import 'movies_repository_provider.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMappertifier, Map<String, Movie>>((ref) {
  final getMovie = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMappertifier(getMovie: getMovie);
});

/// {
///  '450332":Movie(),
///  "342325":Movie(),
/// }

typedef GetMovieCallBack = Future<Movie> Function(String movieId);

class MovieMappertifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;

  MovieMappertifier({required this.getMovie}) : super({});

  Future<void> loadMovie(movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);
    // con el movieId => es la clave del objeto => '43243':Movie()
    state = {...state, movieId: movie};
  }
}
