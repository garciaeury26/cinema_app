import 'package:cinema_app/infreastucture/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infreastucture/datasouerces/actordb_data_source.dart';

final actorsReositoryProvider =
    Provider((ref) => ActorsRepositoryImpl(ActorDbDataSource()));
