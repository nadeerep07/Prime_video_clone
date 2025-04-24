import 'package:amazon_prime_clone/models/popuar_tv_show_model.dart';
import 'package:amazon_prime_clone/models/popular_movies_model.dart';
import 'package:amazon_prime_clone/services/api_services.dart';
import 'package:amazon_prime_clone/widgets/featured_movie_card.dart';
import 'package:amazon_prime_clone/widgets/popular_movies.dart';
import 'package:amazon_prime_clone/widgets/prime_top_silder.dart';
import 'package:flutter/material.dart';

class PrimeScreen extends StatefulWidget {
  const PrimeScreen({super.key});

  @override
  State<PrimeScreen> createState() => _PrimeScreenState();
}

class _PrimeScreenState extends State<PrimeScreen> {
  late Future<MovieResponse> latestMoviesFuture;
  late Future<MovieResponse> topRatedMoviesFuture;
  late Future<PopularTvShowModel> topRatedTvFuture;

  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    latestMoviesFuture = apiServices.getLatestMovie();
    topRatedMoviesFuture = apiServices.getTopMovies();
    topRatedTvFuture = apiServices.getTopTv();
    super.initState();
  }

  Future<void> _refreshMovies() async {
    setState(() {
      latestMoviesFuture = apiServices.getLatestMovie();
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
                      Text(
                        'Prime',
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
              PrimeTopSilder(),
              SizedBox(
                height: 164,
                child: PopularMovies(
                  future: latestMoviesFuture,
                  headLineText: 'Top Movies >',
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                width: 150,
                child: RectangleMovieCard(
                  future: topRatedMoviesFuture,
                  headLineText: 'Featured Originals: Series >',
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 164,
                child: PopularMovies(
                  future: latestMoviesFuture,
                  headLineText: 'Crime Movies >',
                  startIndex: 3,
                ),
              ),
              SizedBox(
                height: 164,
                child: PopularMovies(
                  future: latestMoviesFuture,
                  headLineText: 'Recommended >',
                  startIndex: 5,
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
