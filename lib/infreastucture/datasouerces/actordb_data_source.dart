import 'package:cinema_app/config/constants/enviroments.dart';
import 'package:cinema_app/domain/datasources/actors_data_source.dart';
import 'package:cinema_app/domain/entities/actor.dart';
import 'package:cinema_app/infreastucture/mappers/actor_mapper.dart';
import 'package:cinema_app/infreastucture/models/actors/movie_db_actors.dart';
import 'package:dio/dio.dart';

class ActorDbDataSource implements ActorsDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3/movie/",
      queryParameters: {
        'api_key': Enviroment.movieDbKey,
        "language": 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(int movieId) async {
    final response = await dio.get('/$movieId/credits');

    final List<Cast> creditsResponse =
        CreditsReponse.fromJson(response.data).cast;

    final List<Actor> actors = creditsResponse
        .map((actor) => ActorMapper.castToActorEntity(actor))
        .toList();

    return actors;
  }
}
