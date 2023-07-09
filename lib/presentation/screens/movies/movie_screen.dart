import 'package:animate_do/animate_do.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinema_app/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:cinema_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/actors/actors_by_movie_provider.dart';
import '../../providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie_screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorFromMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    // el provider me manda un mapa con las diferente peliculas
    // y la selecciono con el parametri modieId
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) return const LoadingMessageWidget();

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return _MovieDetails(movie: movie);
            },
            childCount: 1,
          )),
        ],
      ),
    );
  }
}

// ? el => .family => puede recisivir parametros
final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageProvider);

  return localStorageRepository.isMovieInFavorites(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      actions: [
        IconButton(
            onPressed: () {
              // ref.watch(localStorageProvider).toggleFavorite(movie);

              ref.read(favoritesMoviesProvider.notifier).toggleFavorite(movie);
            },
            icon: isFavoriteFuture.when(
              data: (isFavorite) {
                // esto ase refres del estado del  FutureProvider
                ref.invalidate(isFavoriteProvider(movie.id));
                return isFavorite
                    ? const Icon(
                        Icons.favorite_rounded,
                        color: Color.fromARGB(255, 245, 91, 80),
                      )
                    : const Icon(
                        Icons.favorite_border,
                      );
              },
              error: (_, __) => throw UnimplementedError(),
              loading: () => const CircularProgressIndicator(),
            )),
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7, // 70%
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const CustomGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              stops: [0.5, 1],
            ),
            const CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.4, 1],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomGradient extends StatelessWidget {
  final Alignment begin;
  final Alignment end;
  final double transform;
  final List<Color> colors;
  final List<double>? stops;

  static const defaultColors = [
    Colors.transparent,
    Color.fromARGB(192, 0, 0, 0)
  ];

  const CustomGradient({
    super.key,
    this.begin = Alignment.bottomLeft,
    this.end = Alignment.bottomRight,
    this.transform = 90,
    this.colors = defaultColors,
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        stops: stops,
        end: end,
        begin: begin,
        transform: GradientRotation(transform),
        colors: colors,
      )),
    ));
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              // Decripcion
              Expanded(
                child: Text(
                  movie.overview,
                ),
              )
            ],
          ),
        ),

        // generos
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (gender) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(gender),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              )
            ],
          ),
        ),

        // actores
        _ActorByMovie(movieId: movie.id.toString()),

        const SizedBox(height: 100)
      ],
    );
  }
}

class _ActorByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actors = ref.watch(actorFromMovieProvider)[movieId];

    if (actors == null) return const LoadingMessageWidget();

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final actor = actors[index];
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    actor.name,
                    maxLines: 2,
                  ),
                  Text(
                    actor.character ?? '',
                    style: const TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          }),
    );
  }
}
