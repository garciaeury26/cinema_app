import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';

class MovieFavoirteCard extends StatelessWidget {
  final Movie movie;
  const MovieFavoirteCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/movie/${movie.id}');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeIn(
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
