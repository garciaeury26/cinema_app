import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../domain/entities/movie.dart';
import '../widgets.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  final ScrollController scrollController = ScrollController();

  MovieMasonry({
    super.key,
    required this.movies,
    required this.loadNextPage,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      final maxScroll = widget.scrollController.position.maxScrollExtent;

      if (widget.scrollController.position.maxScrollExtent == maxScroll) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
          controller: widget.scrollController,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: widget.movies.length,
          itemBuilder: (contex, index) {
            final movie = widget.movies[index];

            // esto lo hago para darle un stilo como desargonisado
            if (index == 1 && widget.movies.length >= 6) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  MovieFavoirteCard(
                    movie: movie,
                  ),
                ],
              );
            }

            return MovieFavoirteCard(
              movie: movie,
            );
          }),
    );
  }
}
