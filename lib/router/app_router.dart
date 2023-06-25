import 'package:cinema_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      name: const HomeScreen().name,
      builder: (context, state) => const HomeScreen(),
      // childRoutes =>
      // esto me permite optimizar mejor las rutas
      // y permitirme mantener los widgets de appbar y menu
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) => MovieScreen(
            movieId: state.pathParameters['id'] ?? 'no-id',
          ),
        ),
      ]),
]);
