import 'package:cinema_app/infreastucture/models/actors/movie_db_actors.dart';

import '../../domain/entities/actor.dart';

class ActorMapper {
  static Actor castToActorEntity(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
          : 'https://th.bing.com/th/id/OIP.8R95WJtQhwmzvFvd75zrVQHaHa?pid=ImgDet&rs=1',
      character: cast.character,
    );
  }
}
