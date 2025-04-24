import 'dart:async';
import 'package:amazon_prime_clone/models/popular_movies_model.dart';
import 'package:amazon_prime_clone/models/search_model.dart';
import 'package:amazon_prime_clone/screens/detail_screen.dart';
import 'package:amazon_prime_clone/services/api_services.dart';
import 'package:amazon_prime_clone/widgets/language_tile.dart';
import 'package:amazon_prime_clone/widgets/genre_button.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  ApiServices apiServices = ApiServices();

  SearchModel? searchModel;
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        search(query);
      } else {
        setState(() {
          searchModel = null;
        });
      }
    });
  }

  void search(String query) async {
    apiServices.getSearchedMovie(query).then((results) {
      setState(() {
        searchModel = results;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Movie convertResultToMovie(Result result) {
    return Movie(
      title: result.title,
      backdropPath: result.backdropPath ?? '',
      overview: result.overview,
      releaseDate: result.releaseDate?.toIso8601String() ?? '',
      originalLanguage: result.originalLanguage,
      adult: false,
      genreIds: [],
      id: result.id,
      voteCount: 0,
      originalTitle: '',
      posterPath: '',
      popularity: 0.0,
      video: false,
      voteAverage: 0.0,
      // map any other fields if needed
    );
  }

  TextSpan highlightText(String text, String query) {
    final matches = RegExp(
      RegExp.escape(query),
      caseSensitive: false,
    ).allMatches(text);
    if (matches.isEmpty) {
      return TextSpan(text: text, style: const TextStyle(color: Colors.white));
    }

    List<TextSpan> spans = [];
    int start = 0;

    for (final match in matches) {
      if (match.start > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, match.start),
            style: const TextStyle(color: Colors.grey),
          ),
        );
      }

      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      start = match.end;
    }

    if (start < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(start),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          const Icon(Icons.cast, color: Colors.white),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              'assets/images/person_icon.jpg',
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search by actor, title...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: const Icon(Icons.mic, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: onSearchChanged,
              ),

              if (searchModel == null)
                ...[
               
              ] else if (searchModel!.results.isEmpty) ...[
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "No results found.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ] else ...[
                ListView.separated(
                  itemCount: searchModel!.results.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final result = searchModel!.results[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => MovieScreen(
                                  movie: convertResultToMovie(result),
                                ),
                          ),
                        );
                      },

                      child: ListTile(
                        title: RichText(
                          text: highlightText(
                            result.title,
                            _searchController.text,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder:
                      (_, __) => const Divider(color: Colors.grey),
                ),
              ],

              const SizedBox(height: 20),

              const Text(
                'Genres',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3,
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  GenreButton(label: 'Action and \nadventure'),
                  GenreButton(label: 'Anime'),
                  GenreButton(label: 'Comedy'),
                  GenreButton(label: 'Documentary'),
                  GenreButton(label: 'Drama'),
                  GenreButton(label: 'Fantasy'),
                ],
              ),

              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Featured collections',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              const LanguageTile(title: 'Hindi'),
              const LanguageTile(title: 'English'),
              const LanguageTile(title: 'Telugu'),
              const LanguageTile(title: 'Tamil'),
              const LanguageTile(title: 'Malayalam'),

              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
