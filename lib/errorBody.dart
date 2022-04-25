import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fetch_api/screen/home/home.dart';

class ErrorBody extends ConsumerWidget {
  const ErrorBody({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () => ref.refresh(moviesFutureProvider(1)),
            child: const Text("Try again"),
          ),
        ],
      ),
    );
  }
}
