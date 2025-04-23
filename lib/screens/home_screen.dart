import 'package:amazon_prime_clone/models/popular_movies_model.dart';
import 'package:amazon_prime_clone/models/top_rated_movies_model.dart';
import 'package:amazon_prime_clone/models/top_rated_tvshow_model.dart';
import 'package:amazon_prime_clone/services/api_services.dart';
import 'package:amazon_prime_clone/widgets/movie_card.dart';
import 'package:amazon_prime_clone/widgets/rectangle_movie_card.dart';
import 'package:amazon_prime_clone/widgets/top_carousel.dart';
import 'package:amazon_prime_clone/widgets/top_movies.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<MovieResponse> popularMoviesFuture;
  late Future<TopRatedMoviesModel> topRatedMoviesFuture;
  late Future<TopRatedTvShowModel> topRatedTvFuture;

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
          120.0,
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
                      Image.asset(
                        'assets/images/Prime-Video-Logo-PNG-removebg-preview.png',
                        height: 50,
                        width: 70,
                        fit: BoxFit.contain,
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
                            child: CircleAvatar(
                              backgroundColor: Colors.cyan,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.person, color: Colors.white),
                                iconSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Navigation Tabs
                _buildNavigationTabs(),
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
              TopCarousel(),
              SizedBox(
                height: 164,
                child: MovieCard(
                  future: popularMoviesFuture,
                  headLineText: 'Recommended with subscription',
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 197,
                child: RectangleMovieCard(
                  future: topRatedMoviesFuture,
                  headLineText: 'Featured Originals: Series >',
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

  Widget _buildNavigationTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            _buildNavTab('Movies'),
            const SizedBox(width: 10),
            _buildNavTab('TV shows'),
            const SizedBox(width: 10),
            _buildNavTab('Live TV'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTab(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
