import 'package:amazon_prime_clone/models/popular_movies_model.dart';
import 'package:amazon_prime_clone/screens/detail_screen.dart';
import 'package:amazon_prime_clone/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PrimeTopSilder extends StatefulWidget {
  @override
  _PrimeTopSilderState createState() => _PrimeTopSilderState();
}

class _PrimeTopSilderState extends State<PrimeTopSilder> {
  int activeIndex = 0;
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final int totalItems = 12;
  final int visibleDots = 5;
  late Future<MovieResponse> topRatedTVFuture;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    topRatedTVFuture = apiServices.getUpcomingMovie();
  }

  @override
  Widget build(BuildContext context) {
    // final data = apiServices.getPopularMovies();
    // log(data.toString());
    return FutureBuilder<MovieResponse>(
      future: topRatedTVFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // print('Error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data?.results.isEmpty == true) {
          return const Center(child: Text('No movies found'));
        }

        final movies = snapshot.data?.results ?? [];

        return Container(
          height: 240,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index, realIndex) {
                      final movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieScreen(movie: movie),
                            ),
                          );
                        },
                        child: ClipRRect(
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      onPageChanged:
                          (index, reason) =>
                              setState(() => activeIndex = index),
                    ),
                  ),

                  const Positioned(
                    bottom: 10,
                    left: 10,
                    child: Row(
                      children: [
                        Icon(Icons.local_mall, color: Colors.yellow, size: 16),
                        SizedBox(width: 5),
                        Text(
                          'First episode free',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: movies.length,
                effect: const ScrollingDotsEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                  dotHeight: 6,
                  dotWidth: 6,
                  spacing: 6,
                  fixedCenter: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
