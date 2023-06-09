import 'package:cinema_app/domain/datasources/actors_data_source.dart';
import 'package:cinema_app/domain/entities/actor.dart';
import 'package:cinema_app/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDataSource dataSource;

  ActorsRepositoryImpl(this.dataSource);

  @override
  Future<List<Actor>> getActors(String movieId) {
    return dataSource.getActorsByMovie(movieId);
  }
}
