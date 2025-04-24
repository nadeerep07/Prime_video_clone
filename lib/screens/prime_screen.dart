import 'package:amazon_prime_clone/helper/responsive_helper.dart';
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
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          responsive.isMobile
              ? responsive.height * 0.14
              : responsive.height * 0.12,
        ),
        child: Container(
          color: Colors.black,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top row with logo and actions
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.width * 0.03,
                  ),
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
                            icon: Icon(
                              Icons.cast,
                              color: Colors.white,
                              size: responsive.isMobile ? 24 : 28,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.width * 0.02,
                            ),
                            child: Image.asset(
                              'assets/images/person_icon.jpg',
                              height:
                                  responsive.isMobile
                                      ? responsive.height * 0.05
                                      : responsive.height * 0.06,
                              width:
                                  responsive.isMobile
                                      ? responsive.width * 0.1
                                      : responsive.width * 0.08,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Navigation Tabs
                _buildNavigationTabs(responsive),
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
              SizedBox(
                height:
                    responsive.isMobile
                        ? responsive.height * 0.28
                        : responsive.height * 0.35,
                child: PrimeTopSilder(),
              ),

              SizedBox(
                height:
                    responsive.isMobile
                        ? responsive.height * 0.2
                        : responsive.height * 0.25,
                child: PopularMovies(
                  future: latestMoviesFuture,
                  headLineText: 'Top Movies >',
                ),
              ),
              SizedBox(height: responsive.height * 0.01),
              SizedBox(
                height:
                    responsive.isMobile
                        ? responsive.height * 0.30
                        : responsive.height * 0.3,
                width:
                    responsive.isMobile
                        ? responsive.width * 0.4
                        : responsive.width * 0.3,
                child: RectangleMovieCard(
                  future: topRatedMoviesFuture,
                  headLineText: 'Featured Originals: Series >',
                ),
              ),
              SizedBox(height: responsive.height * 0.01),
              SizedBox(
                height:
                    responsive.isMobile
                        ? responsive.height * 0.2
                        : responsive.height * 0.25,
                child: PopularMovies(
                  future: latestMoviesFuture,
                  headLineText: 'Crime Movies >',
                  startIndex: 3,
                ),
              ),
              SizedBox(
                height:
                    responsive.isMobile
                        ? responsive.height * 0.2
                        : responsive.height * 0.25,
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

  Widget _buildNavigationTabs(Responsive responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.height * 0.01),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsive.width * 0.03),
        child: Row(
          children: [
            _buildNavTab('Movies', responsive),
            SizedBox(width: responsive.width * 0.03),
            _buildNavTab('TV shows', responsive),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTab(String title, Responsive responsive) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.width * 0.03,
        vertical: responsive.height * 0.005,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: responsive.isMobile ? 12 : 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
