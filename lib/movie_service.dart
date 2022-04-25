import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fetch_api/screen/detailView/genres.dart';
import 'package:riverpod_fetch_api/screen/detailView/movie_detail.dart';
import 'package:riverpod_fetch_api/screen/home/movie.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  return MovieService(Dio());
});

const apiKey = "5b361fbe2d7d88b357805e82b07f5ec6";

class MovieService {
  MovieService(
    this._dio,
  );

  final Dio _dio;

  Future<List<Movie>> getMovies(int page) async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=$page',
      );

      final results = List<Map<String, dynamic>>.from(response.data['results']);

      List<Movie> movies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);
      return movies;
    } on DioError catch (dioError) {
      throw '$dioError';
    }
  }

  Future<DetailMovie> getDetailMovie(String id) async {
    try {
      final response = await _dio
          .get('https://api.themoviedb.org/3/movie/$id?api_key=$apiKey');
      DetailMovie detail = DetailMovie.fromJson(response.data);
      return detail;
    } on DioError catch (dioError) {
      throw '$dioError';
    }
  }
}
