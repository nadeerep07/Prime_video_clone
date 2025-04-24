import 'package:amazon_prime_clone/helper/responsive_helper.dart';
import 'package:amazon_prime_clone/services/api_services.dart';
import 'package:amazon_prime_clone/widgets/info_section.dart';
import 'package:amazon_prime_clone/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:amazon_prime_clone/models/popuar_tv_show_model.dart';
import 'package:amazon_prime_clone/models/popular_movies_model.dart';

class MovieScreen extends StatefulWidget {
  final Movie? movie;
  final TvShow? tvShow;

  const MovieScreen({Key? key, this.movie, this.tvShow})
    : assert(
        movie != null || tvShow != null,
        'Either movie or tvShow must be provided',
      ),
      super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  Future<MovieResponse>? topRatedMovie;
  ApiServices apiServices = ApiServices();
  bool get isMovie => widget.movie != null;
  @override
  void initState() {
    topRatedMovie = apiServices.getLatestMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final backdropPath =
        isMovie ? widget.movie!.backdropPath : widget.tvShow!.backdropPath;
    final title = isMovie ? widget.movie!.title : widget.tvShow!.name;
    final overview = isMovie ? widget.movie!.overview : widget.tvShow!.overview;
    final releaseDate =
        isMovie ? widget.movie!.releaseDate : widget.tvShow!.firstAirDate;
    final language =
        isMovie
            ? widget.movie!.originalLanguage
            : widget.tvShow!.originalLanguage;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.cast,
              color: Colors.white,
              size: responsive.isMobile ? 24 : 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsive.width * 0.02),
            child: Image.asset(
              'assets/images/person_icon.jpg',
              height: responsive.isMobile ? 40 : 50,
              width: responsive.isMobile ? 40 : 50,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height:
                      responsive.isMobile
                          ? responsive.height * 0.35
                          : responsive.height * 0.45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500$backdropPath',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height:
                      responsive.isMobile
                          ? responsive.height * 0.35
                          : responsive.height * 0.45,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(responsive.width * 0.04),
                  child: Text(
                    "Title: $title",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.isMobile ? 24 : 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.width * 0.04,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_mall, color: Colors.yellow, size: 14),
                      SizedBox(width: responsive.width * 0.01),
                      Text(
                        'Watch with a Prime membership',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.isMobile ? 12 : 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: responsive.height * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.width * 0.04,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(
                        responsive.width * 0.9,
                        responsive.height * 0.06,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      "Watch with Prime",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.isMobile ? 16 : 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.height * 0.02),
                SizedBox(
                  height: responsive.height * 0.12,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.width * 0.04,
                    ),
                    children: [
                      _iconWithLabel(
                        context,
                        Icons.theaters_outlined,
                        'Trailer',
                      ),
                      SizedBox(width: responsive.width * 0.04),
                      _iconWithLabel(context, Icons.add, 'Watchlist'),
                      SizedBox(width: responsive.width * 0.04),
                      _iconWithLabel(
                        context,
                        Icons.thumb_up_alt_outlined,
                        'Like',
                      ),
                      SizedBox(width: responsive.width * 0.04),
                      _iconWithLabel(
                        context,
                        Icons.thumb_down_alt_outlined,
                        'Not for me',
                      ),
                      SizedBox(width: responsive.width * 0.04),
                      _iconWithLabel(context, Icons.share_outlined, 'Share'),
                    ],
                  ),
                ),
                SizedBox(height: responsive.height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.width * 0.04,
                  ),
                  child: Text(
                    overview,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.isMobile ? 16 : 18,
                    ),
                  ),
                ),
                SizedBox(height: responsive.height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.width * 0.04,
                  ),
                  child: Text(
                    releaseDate.toString().substring(0, 4),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: responsive.isMobile ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: responsive.height * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.width * 0.04,
                  ),
                  child: Text(
                    'Languages',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: responsive.isMobile ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: responsive.height * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.width * 0.04,
                  ),
                  child: Text(
                    language.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.isMobile ? 16 : 18,
                    ),
                  ),
                ),
                SizedBox(height: responsive.height * 0.02),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          insets: EdgeInsets.symmetric(
                            horizontal: responsive.width * 0.3,
                          ),
                        ),
                        labelColor: Colors.grey,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: 'Related',
                            iconMargin: EdgeInsets.only(
                              bottom: responsive.isMobile ? 0 : 4,
                            ),
                          ),
                          Tab(
                            text: 'More Details',
                            iconMargin: EdgeInsets.only(
                              bottom: responsive.isMobile ? 0 : 4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            responsive.isMobile
                                ? responsive.height * 0.35
                                : responsive.height * 0.4,
                        child: TabBarView(
                          children: [
                            // Related tab content
                            Column(
                              children: [
                                SizedBox(
                                  height:
                                      responsive.isMobile
                                          ? responsive.height * 0.3
                                          : responsive.height * 0.35,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.all(
                                      responsive.width * 0.04,
                                    ),
                                    children: [
                                      SizedBox(
                                        width:
                                            responsive.isMobile
                                                ? responsive.width * 1
                                                : responsive.width * 0.4,
                                        child: MovieCard(
                                          future: topRatedMovie,
                                          startIndex: 2,
                                          headLineText: 'Customer also watched',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // More Details tab content
                            SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(
                                  responsive.width * 0.04,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: InfoSection(
                                        title: 'Genre',
                                        description:
                                            'Action, Adventure, Comedy',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: InfoSection(
                                        title: 'Director',
                                        description: 'John Doe',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: InfoSection(
                                        title: 'Cast',
                                        description:
                                            'John Doe, Jane Smith, Bob Johnson',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: InfoSection(
                                        title: 'Studio',
                                        description: 'Warner Bros.',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: InfoSection(
                                        title: 'Maturity Rating',
                                        description: 'PG-13',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: InfoSection(
                                        title: 'Content Advisory',
                                        description: 'Mild Violence, Language',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWithLabel(BuildContext context, IconData icon, String label) {
    final responsive = Responsive(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.width * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: responsive.isMobile ? 25 : 30),
          SizedBox(height: responsive.height * 0.01),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: responsive.isMobile ? 12 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
