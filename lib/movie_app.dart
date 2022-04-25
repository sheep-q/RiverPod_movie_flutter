import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fetch_api/screen/detailView/detail_view.dart';
import 'screen/home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie - River pod - Dio',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeView(),
      onGenerateRoute: (settings) {
        if (settings == null) {
          return null;
        }
        final split = settings.name!.split('/');
        Widget? result;

        if (settings.name!.startsWith('/detail/')) {
          result = ProviderScope(
            overrides: [
              selectedMovieId.overrideWithValue(split.last),
            ],
            child: const DetailView(),
          );
        }

        if (result == null) {
          return null;
        }
        return MaterialPageRoute<void>(builder: (context) => result!);
      },
      routes: {
        '/detail': (c) => const DetailView(),
      },
    );
  }
}
