import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/domain/repositories/local_storage_repository.dart';

import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesMoviesProvider =
    StateNotifierProvider<FavoritesMoviesNofitier, Map<int, Movie>>((ref) {
  final localStorageRepositoryProvider = ref.watch(localStorageProvider);
  return FavoritesMoviesNofitier(
    localStorageRepository: localStorageRepositoryProvider,
  );
});

///  {
/// 1234:Movie(),
/// 154:Movie(),
/// }

class FavoritesMoviesNofitier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  FavoritesMoviesNofitier({
    required this.localStorageRepository,
  }) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
        offset: page * 10); // 0*10 = 0, 1*10 = 10, 2*10 = 20, 3*10 = 30
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie; // -> {3324: Movie()}
    }
    state = {...state, ...tempMoviesMap};
    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInfavorites = state[movie.id] != null;

    if (isMovieInfavorites) {
      // si existe en favoritos la removue y cambio el estado
      state.remove(movie.id);
      state = {...state};
    } else {
      // si no exite mantengo el estado anterior y creo el nuevo mapa
      state = {...state, movie.id: movie};
    }
  }
}
