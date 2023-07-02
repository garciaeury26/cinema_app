import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/helpers/human_format.dart';
import '../../../domain/entities/movie.dart';

class MovieSearchItem extends StatelessWidget {
  final Movie movie;
  // rese una funcion que sera la de close => nativa de flutter
  // para serra el searchDeletgate
  final Function onMovieSelected;

  const MovieSearchItem(
      {super.key, required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
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
      ),
    );
  }
}
