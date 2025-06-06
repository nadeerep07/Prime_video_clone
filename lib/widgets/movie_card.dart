import 'package:amazon_prime_clone/models/popular_movies_model.dart';
import 'package:amazon_prime_clone/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Future<MovieResponse>? future;
  // final Future<TopRatedMoviesModel> future;
  final String headLineText;
  final int startIndex;
  const MovieCard({
    super.key,
    required this.future,
    required this.headLineText,
    this.startIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data?.results.isEmpty == true) {
          return const Center(child: Text('No movies found'));
        }
        var data = snapshot.data?.results;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                headLineText,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: (data!.length - startIndex).clamp(0, data.length),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: 200,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MovieScreen(
                                      movie: data[index + startIndex],
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${data[index + startIndex].posterPath}",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 4,
                          left: 4,
                          child: Row(
                            children: [
                              Icon(
                                Icons.local_mall,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'subscribe or rent',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
