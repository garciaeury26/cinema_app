import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:cinema_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<FavoritesView> {
  bool isLoading = true;
  bool isFinalPage = false;
  _HomeViewState();

  @override
  void initState() {
    super.initState();
    loaddNextPage();
  }

  loaddNextPage() async {
    if (!isLoading || isFinalPage) {
      return;
    }

    isLoading = false;
    final movies =
        await ref.read(favoritesMoviesProvider.notifier).loadNextPage();
    isLoading = true;

    if (movies.isEmpty) {
      isFinalPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(favoritesMoviesProvider).values.toList();

    const noFavorites = Center(
      child: Text('No favorites in your list'),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoritesMovies.isNotEmpty
          ? MovieMasonry(
              movies: favoritesMovies,
              loadNextPage: loaddNextPage,
            )
          : noFavorites,
    );
  }
}
