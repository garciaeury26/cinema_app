import 'package:cinema_app/domain/datasources/actors_data_source.dart';
import 'package:cinema_app/domain/entities/actor.dart';

class ActorDbDataSource implements ActorsDataSource {
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    throw UnimplementedError();
  }
}
