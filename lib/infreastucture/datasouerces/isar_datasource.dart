import 'package:cinema_app/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/datasources/local_storage_datasource.dart';

class IsarDataSource extends LocalStorageDataSource {
  late Future<Isar> db;

  IsarDataSource() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    //obtiene el directorio de documentos de la aplicación
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      // MovieSchema => es lo que genera el paque segundo la entidad
      return await Isar.open([MovieSchema], directory: dir.path);
    }

    //  para mantener la consistencia del tipo de retorno.
    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final isMovieInFavorites =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    // agregar
    if (isMovieInFavorites == null) {
      isar.writeTxnSync(() => isar.movies.putSync(movie));
      return;
    }

    // borrar
    isar.writeTxnSync(() => isar.movies.deleteSync(movie.id));
  }

  @override
  Future<bool> isMovieInFavorites(int movieId) async {
    final isar = await db;

    // el metodo =>  idEqualTo es generado segun la propiedad a la que se quiere manaipular
    final Movie? isInFavoriteList =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isInFavoriteList != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    final movies =
        await isar.movies.where().offset(offset).limit(limit).findAll();

    return movies;
  }
}
