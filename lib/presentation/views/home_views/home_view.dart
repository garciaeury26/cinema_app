import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:cinema_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/shared/full_screen_loader.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initalLoading = ref.watch(initialLoadingProvider);
    if (initalLoading) {
      return FullScreenLoader();
    }

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topMovies = ref.watch(topMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);

    //  CustomScrollView => me permite crear un custom scroll
    return CustomScrollView(slivers: [
      // me permite crear appbar que responde al moviento del scroll
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // const CustomAppBar(),
            MoviesSliderShow(movies: slideShowMovies),
            MoviesHorizontalListView(
              movies: nowPlayingMovies,
              title: 'In Streming',
              subTitle: 'Monday 20',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MoviesHorizontalListView(
              movies: popularMovies,
              title: 'Popular',
              subTitle: 'Now',
              loadNextPage: () =>
                  ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
            MoviesHorizontalListView(
              movies: topMovies,
              title: 'Top movies',
              subTitle: 'Best',
              loadNextPage: () =>
                  ref.read(topMoviesProvider.notifier).loadNextPage(),
            ),
            MoviesHorizontalListView(
              movies: upComingMovies,
              title: 'Upcomig',
              subTitle: 'cinema',
              loadNextPage: () =>
                  ref.read(upComingMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        );
      }, childCount: 1))
    ]);
  }
}
