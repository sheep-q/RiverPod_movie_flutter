import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fetch_api/errorBody.dart';
import 'package:riverpod_fetch_api/movie_service.dart';
import 'package:riverpod_fetch_api/screen/detailView/header_view.dart';
import 'package:riverpod_fetch_api/screen/detailView/movie_detail.dart';
import 'package:percent_indicator/percent_indicator.dart';

final selectedMovieId = Provider<String>((ref) {
  throw UnimplementedError();
});

final movieDetailsFutureProvider =
    FutureProvider.autoDispose.family<DetailMovie, String>((ref, id) async {
  ref.maintainState = true;

  final movieService = ref.watch(movieServiceProvider);
  final detailMovie = await movieService.getDetailMovie(id);
  return detailMovie;
});

class DetailView extends ConsumerWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(selectedMovieId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Movie details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
      ),
      body: ref.watch(movieDetailsFutureProvider(id)).when(
          error: (e, s) {
            return ErrorBody(message: 'Oops, something unexpected happened');
          },
          loading: () => Center(child: CircularProgressIndicator()),
          data: (detail) {
            return SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderView(
                      fullBGImageUrl: detail.fullBGImageUrl,
                      fullImageUrl: detail.fullImageUrl,
                    ),
                    // Title and Rate
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            detail.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          CircularPercentIndicator(
                            radius: 20.0,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: 5,
                            percent: detail.voteAverage / 10,
                            center: Text(
                              '${detail.voteAverage}',
                              style: TextStyle(fontSize: 15),
                            ),
                            circularStrokeCap: CircularStrokeCap.butt,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),

                    // Reviews and Trailer
                    SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: Row(
                        children: [
                          Spacer(),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/icons/reivews.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              Text('Reviews', style: TextStyle(fontSize: 16))
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: double.infinity,
                            width: 1.5,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey),
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/icons/trailer.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              Text('Trailers', style: TextStyle(fontSize: 16))
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),

                    // Genre and Release
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                'Gernes',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                detail.genres.first.name,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Spacer(),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                'Release',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                detail.releaseDate,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Divider(thickness: 2),

                    // Overview Text
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        detail.overview,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
