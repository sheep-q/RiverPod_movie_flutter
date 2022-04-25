import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fetch_api/errorBody.dart';
import 'package:riverpod_fetch_api/movie_service.dart';
import 'package:riverpod_fetch_api/screen/detailView/detail_view.dart';
import 'movie.dart';
import 'movie_box.dart';

final moviesFutureProvider = FutureProvider.autoDispose
    .family<List<Movie>, int>((ref, currentPage) async {
  //to preserve the state so that the request does not fire again if the user leaves and re-enters the same screen.
  ref.maintainState = true;

  final movieService = ref.watch(movieServiceProvider);
  final movies = await movieService.getMovies(currentPage);
  var oldMovie = ref.watch(totalMoviesProvider);
  var list = oldMovie += movies;
  ref.read(totalMoviesProvider).addAll(movies);
  return list;
});

final totalMoviesProvider = StateProvider<List<Movie>>((ref) => []);

final currentPageProvider = StateProvider((ref) => 1);

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // loadmore
        ref.read(currentPageProvider.state).state++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(currentPageProvider.state).state;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Popular',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
      ),
      body: ref.watch(moviesFutureProvider(currentPage)).when(
            error: (e, s) {
              return const ErrorBody(
                  message: "Oops, something unexpected happened");
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (movies) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.read(totalMoviesProvider).clear();
                  ref.read(currentPageProvider.state).state = 1;
                  return ref.refresh(moviesFutureProvider(1));
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: movies.length + 1,
                  itemBuilder: (context, index) {
                    if (index == movies.length) {
                      return CupertinoActivityIndicator();
                    }
                    return MovieBox(movie: movies[index]);
                  },
                ),
              );
            },
          ),
    );
  }
}
