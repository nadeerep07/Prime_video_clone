import 'dart:convert';
import 'dart:developer';

import 'package:amazon_prime_clone/common/utils.dart';
import 'package:amazon_prime_clone/models/popular_movies_model.dart';
import 'package:amazon_prime_clone/models/top_rated_movies_model.dart';
import 'package:amazon_prime_clone/models/top_rated_tvshow_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<MovieResponse> getPopularMovies() async {
    endPoint = "movie/top_rated";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Response:${response.body}");
      return MovieResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies");
  }

  Future<TopRatedMoviesModel> getTopMovies() async {
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Response: sucess");
      return TopRatedMoviesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Top Rated movies");
  }

  Future<TopRatedTvShowModel> getTopTv() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Response: sucess");
      return TopRatedTvShowModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Top Rated movies");
  }
}
