import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../movies/movies_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedNotifierProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final searchMovie = ref.read(movieRepositoryProvider).searchMovie;
  return SearchedMoviesNotifier(
    ref: ref,
    searchMovies: searchMovie,
  );
});

typedef GetMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final Ref ref;
  final GetMoviesCallBack searchMovies;

  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);

  Future<List<Movie>> searMovieQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);

    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}
