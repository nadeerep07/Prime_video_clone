import 'package:amazon_prime_clone/models/popuar_tv_show_model.dart';
import 'package:amazon_prime_clone/models/popular_movies_model.dart';
import 'package:amazon_prime_clone/services/api_services.dart';
import 'package:amazon_prime_clone/widgets/movie_card.dart';
import 'package:amazon_prime_clone/widgets/featured_movie_card.dart';
import 'package:amazon_prime_clone/widgets/sub_top_slider.dart';
import 'package:amazon_prime_clone/widgets/top_movies.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late Future<MovieResponse> popularMoviesFuture;
  late Future<MovieResponse> topRatedMoviesFuture;
  late Future<PopularTvShowModel> topRatedTvFuture;

  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    popularMoviesFuture = apiServices.getPopularMovies();
    topRatedMoviesFuture = apiServices.getTopMovies();
    topRatedTvFuture = apiServices.getTopTv();
    super.initState();
  }

  Future<void> _refreshMovies() async {
    setState(() {
      popularMoviesFuture = apiServices.getPopularMovies();
      topRatedMoviesFuture = apiServices.getTopMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          80.0,
        ), // Increased height to fit tabs
        child: Container(
          color: Colors.black,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top row with logo and actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subscription',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.cast, color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Image.asset(
                              'assets/images/person_icon.jpg',
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.cyan,
        backgroundColor: Colors.black,
        onRefresh: _refreshMovies,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SubTopSlider(),
              SizedBox(
                height: 164,
                child: MovieCard(
                  future: popularMoviesFuture,
                  headLineText: 'discovery+: Most popular >',
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                width: 150,
                child: RectangleMovieCard(
                  future: topRatedMoviesFuture,
                  headLineText: 'Subscription you might like ',
                ),
              ),
              SizedBox(
                height: 197,
                child: TopMovies(
                  future: topRatedTvFuture,
                  headLineText: 'Top tv shows >',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
