import 'package:animate_do/animate_do.dart';
import 'package:cinema_app/config/helpers/human_format.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';

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
            return _MovieSearchItem(movie: movie);
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

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;

  const _MovieSearchItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) =>
                    FadeIn(child: child),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (movie.title.length >= 40)
                        ? '${movie.title.substring(0, 40)}...'
                        : movie.title,
                    style: textStyle.titleSmall,
                    softWrap: true,
                  ),
                  Wrap(
                    spacing: 7,
                    alignment: WrapAlignment.start,
                    children: [
                      Text(
                        '${movie.voteAverage.toString().substring(0, 3)}/10',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 69, 183, 236),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        movie.releaseDate?.year.toString() ?? 'no-year',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 111, 122, 128),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Wrap(
                        spacing: 5,
                        children: [
                          const Icon(
                            Icons.remove_red_eye_sharp,
                            size: 18,
                            color: Color.fromARGB(255, 158, 140, 133),
                          ),
                          Text(
                            HumanFormat.number(movie.popularity),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 111, 122, 128)),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
