// este mapper es para mapear la data de la respuesta como la queremos
// ya que esa puede cambiar a ser una api publica

import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/infreastucture/models/movieDb/movie_movieDb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieFromMovieDb movieDb) {
    return Movie(
        adult: movieDb.adult,
        backdropPath: movieDb.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${movieDb.backdropPath}'
            : 'https://chim-chimneyinc.com/wp-content/uploads/2019/12/GettyImages-1128826884.jpg',
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        posterPath: movieDb.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${movieDb.posterPath}'
            : 'no-poster',
        releaseDate: movieDb.releaseDate,
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount);
  }
}
