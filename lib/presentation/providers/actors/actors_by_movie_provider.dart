import 'package:cinema_app/domain/entities/actor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import 'actor_repositoy_provider.dart';

final movieInfoProvider =
    StateNotifierProvider<ActorsByMovie, Map<String, List<Actor>>>((ref) {
  final getActors = ref.watch(actorsReositoryProvider).getActors;
  return ActorsByMovie(getActors: getActors);
});

/// {
///  '450332":List<Actor>,
/// }

typedef GetMovieCallBack = Future<List<Actor>> Function(int actorId);

class ActorsByMovie extends StateNotifier<Map<String, List<Actor>>> {
  final GetMovieCallBack getActors;

  ActorsByMovie({required this.getActors}) : super({});

  Future<void> loadMovie(movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actor = await getActors(movieId);
    // con el actorId => es la clave del objeto => '43243':Movie()
    state = {...state, movieId: actor};
  }
}
