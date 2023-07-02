import 'package:cinema_app/presentation/delegates/search_movie_delegate.dart';
import 'package:cinema_app/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinema_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    final movieRepository = ref.read(movieRepositoryProvider);

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.movie_outlined,
                  color: colors.primary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Cinemapedia',
                  style: titleStyle,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SearchMovieDelegate(
                        searchMovies: movieRepository.searchMovie,
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
          ),
        ));
  }
}
