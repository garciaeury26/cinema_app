import 'package:cinema_app/infreastucture/datasouerces/isar_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infreastucture/repositories/local_storage_repository_impl.dart';

final localStorageProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(dataSource: IsarDataSource());
});
