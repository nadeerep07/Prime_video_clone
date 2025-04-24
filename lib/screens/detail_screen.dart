import 'package:flutter/material.dart';
import 'package:amazon_prime_clone/models/popuar_tv_show_model.dart';
import 'package:amazon_prime_clone/models/popular_movies_model.dart';

class MovieScreen extends StatelessWidget {
  final Movie? movie;
  final TvShow? tvShow;

  const MovieScreen({Key? key, this.movie, this.tvShow})
    : assert(
        movie != null || tvShow != null,
        'Either movie or tvShow must be provided',
      ),
      super(key: key);

  bool get isMovie => movie != null;

  @override
  Widget build(BuildContext context) {
    final backdropPath = isMovie ? movie!.backdropPath : tvShow!.backdropPath;
    final title = isMovie ? movie!.title : tvShow!.name;
    final overview = isMovie ? movie!.overview : tvShow!.overview;
    final releaseDate = isMovie ? movie!.releaseDate : tvShow!.firstAirDate;
    final language =
        isMovie ? movie!.originalLanguage : tvShow!.originalLanguage;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.cast, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              'assets/images/person_icon.jpg',
              height: 40,
              width: 40,
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
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500$backdropPath',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(height: 300, color: Colors.black.withOpacity(0.4)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Title: $title",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: const [
                      Icon(Icons.local_mall, color: Colors.yellow, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Watch with a Prime membership',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(340, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      "Watch with Prime",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _iconWithLabel(Icons.theaters_outlined, 'Trailer'),
                      const SizedBox(width: 15),
                      _iconWithLabel(Icons.add, 'Watchlist'),
                      const SizedBox(width: 15),
                      _iconWithLabel(Icons.thumb_up_alt_outlined, 'Like'),
                      const SizedBox(width: 15),
                      _iconWithLabel(
                        Icons.thumb_down_alt_outlined,
                        'Not for me',
                      ),
                      const SizedBox(width: 15),
                      _iconWithLabel(Icons.share_outlined, 'Share'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    overview,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    releaseDate.toString().substring(0, 4),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Languages',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    language.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWithLabel(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 25),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
