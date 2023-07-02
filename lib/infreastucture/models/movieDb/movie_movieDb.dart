// Esta es la movie basa en la respuesta de la api es difente a la otra
class MovieFromMovieDb {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieFromMovieDb({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieFromMovieDb.fromJson(Map<String, dynamic> json) =>
      MovieFromMovieDb(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ??
            'https://th.bing.com/th/id/R.422000335cf66085f9d8b39081096bde?rik=TpwN0%2fraVu%2b2BA&pid=ImgRaw&r=0',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ??
            'https://th.bing.com/th/id/R.422000335cf66085f9d8b39081096bde?rik=TpwN0%2fraVu%2b2BA&pid=ImgRaw&r=0',
        releaseDate: json["release_date"] != null &&
                json["release_date"].toString().isNotEmpty
            ? DateTime.parse(json["release_date"])
            : null,
        title: json["title"] ?? 'No title',
        video: json["video"] ?? 'No video',
        voteAverage: json["vote_average"]?.toDouble() ?? 0,
        voteCount: json["vote_count"] ?? 0,
      );
}
