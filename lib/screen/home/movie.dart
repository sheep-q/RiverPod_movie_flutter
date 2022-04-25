import 'dart:convert';

class Movie {
  int id;
  String title;
  String posterPath;
  String overview;
  String backdropPath;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.backdropPath,
  });

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';
  String get fullBGImageUrl => 'https://image.tmdb.org/t/p/w400$backdropPath';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'backdrop_path': backdropPath,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      overview: map['overview'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
