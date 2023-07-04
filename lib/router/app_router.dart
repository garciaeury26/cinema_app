import 'package:cinema_app/presentation/screens/screens.dart';
import 'package:cinema_app/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  ShellRoute(
    // segun el path de ruta que este asociado
    // a un widget  este es que se pasara a el parametro child
    builder: (context, state, child) {
      return HomeScreen(childView: child);
    },
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) => MovieScreen(
                movieId: state.pathParameters['id'] ?? 'no-id',
              ),
            ),
            GoRoute(
              path: 'favorites',
              builder: (context, state) {
                return const FavoritesView();
              },
            ),
          ]),
    ],
  )

  // GoRoute(
  //     path: '/',
  //     name: HomeScreen.name,
  //     builder: (context, state) => const HomeScreen(childView: HomeView()),
  //     // childRoutes =>
  //     // esto me permite optimizar mejor las rutas
  //     // y permitirme mantener los widgets de appbar y menu
  //     routes: [
  //       GoRoute(
  //         path: 'movie/:id',
  //         name: MovieScreen.name,
  //         builder: (context, state) => MovieScreen(
  //           movieId: state.pathParameters['id'] ?? 'no-id',
  //         ),
  //       ),
  //     ]),
]);
