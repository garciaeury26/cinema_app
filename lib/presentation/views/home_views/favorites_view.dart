import 'package:cinema_app/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:cinema_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoritesMovies.isEmpty
          ? MovieMasonry(
              movies: favoritesMovies,
              loadNextPage: loaddNextPage,
            )
          : _Nofavorites(),
    );
  }
}

class _Nofavorites extends StatelessWidget {
  const _Nofavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/imgs/no_favorites.png', width: 150),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'No favorites',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'You haven’t liked any items yet.',
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => context.push('/'),
            child: const Text('Start to explore movies'),
          )
        ],
      ),
    );
  }
}
