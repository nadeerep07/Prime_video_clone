import 'package:amazon_prime_clone/helper/responsive_helper.dart';
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
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          color: Colors.black,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.width * 0.03,
                  ),
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
                child: SubTopSlider(),
              ),

              SizedBox(
                height:
                    responsive.isMobile
                        ? responsive.height * 0.2
                        : responsive.height * 0.25,
                child: MovieCard(
                  future: popularMoviesFuture,
                  headLineText: 'discovery+: Most popular >',
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
                  headLineText: 'Subscription you might like ',
                ),
              ),
              SizedBox(height: responsive.height * 0.01),
              SizedBox(
                height:
                    responsive.isMobile
                        ? responsive.height * 0.2
                        : responsive.height * 0.25,
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
