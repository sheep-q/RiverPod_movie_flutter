import 'package:riverpod_fetch_api/screen/detailView/genres.dart';

class DetailMovie {
  int id;
  String title;
  String posterPath;
  String overview;
  String backdropPath;
  int voteCount;
  double voteAverage;
  String releaseDate;
  List<Genres> genres;

  DetailMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.backdropPath,
    required this.voteCount,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
  });

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';
  String get fullBGImageUrl => 'https://image.tmdb.org/t/p/w400$backdropPath';

  factory DetailMovie.fromJson(Map<String, dynamic> json) {
    return DetailMovie(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteCount: json['vote_count'] ?? 0,
      voteAverage: json['vote_average'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      genres: List<Genres>.from(json["genres"].map((x) => Genres.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'backdrop_path': backdropPath,
      'vote_count': voteCount,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
    };
  }
}
