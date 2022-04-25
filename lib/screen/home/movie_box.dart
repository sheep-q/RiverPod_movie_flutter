import 'package:flutter/material.dart';
import 'movie.dart';

class MovieBox extends StatelessWidget {
  final Movie movie;

  const MovieBox({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail/${movie.id}');
          },
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              Image.network(
                movie.fullImageUrl,
                fit: BoxFit.cover,
                width: 120,
                height: 180,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(fontSize: 22),
                      maxLines: 2,
                    ),
                    SizedBox(height: 10),
                    Text(
                      movie.overview,
                      maxLines: 8,
                      // overflow: TextOverflow.ellipsis,
                      // textDirection: TextDirection.rtl,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
        ),
        SizedBox(height: 15)
      ],
    );
  }
}
