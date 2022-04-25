import 'dart:convert';

class Genres {
  Genres({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
