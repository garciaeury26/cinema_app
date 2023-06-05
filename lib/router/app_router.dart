import 'package:go_router/go_router.dart';

import '../presentation/screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: const HomeScreen().name,
    builder: (context, state) => const HomeScreen(),
  )
]);
