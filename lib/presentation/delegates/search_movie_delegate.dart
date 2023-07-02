import 'package:animate_do/animate_do.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';

import '../widgets/movies/movie_search_item.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallBack searchMovies;

  SearchMovieDelegate({required this.searchMovies});

  // esto es opcional => default => Search;
  @override
  String get searchFieldLabel => 'Search Movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // se actualiza cada vez que cambia
    // print('query: $query');

    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          // researt el texto
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  // opcional
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (BuildContext context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieSearchItem(
              movie: movie,
              onMovieSelected: close,
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('buildSuggestions');
  }
}
