import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';

class MoviesSliderShow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSliderShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
          // para ver el slide anterior y el siguiente
          viewportFraction: 0.8,
          // efecto
          scale: 0.9,
          autoplay: true,
          pagination: SwiperPagination(
              margin: const EdgeInsets.only(top: 0),
              builder: DotSwiperPaginationBuilder(
                  activeColor: colors.primary, color: colors.onSecondary)),
          itemCount: movies.length,
          itemBuilder: (context, index) => _Slider(movie: movies[index])),
    );
  }
}

class _Slider extends StatelessWidget {
  final Movie movie;
  const _Slider({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, -10))
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black12));
                }
                return FadeIn(child: child);
              },
            )),
      ),
    );
  }
}
