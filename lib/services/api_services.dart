import 'dart:convert';
import 'dart:developer';

import 'package:amazon_prime_clone/common/utils.dart';
import 'package:amazon_prime_clone/models/popuar_tv_show_model.dart';
import 'package:amazon_prime_clone/models/popular_movies_model.dart';
import 'package:amazon_prime_clone/models/search_model.dart';

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
      // log("Response:${response.body}");
      return MovieResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies");
  }

  Future<MovieResponse> getTopMovies() async {
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Response: sucess");
      return MovieResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Top Rated movies");
  }

  Future<PopularTvShowModel> getTopTv() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Response: sucess");
      return PopularTvShowModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Top Rated movies");
  }

  Future<MovieResponse> getLatestMovie() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load latest movies");
  }

  Future<PopularTvShowModel> getPopularTvShow() async {
    endPoint = "tv/popular";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PopularTvShowModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular tv shows");
  }

  Future<MovieResponse> getUpcomingMovie() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load latest movies");
  }

  Future<SearchModel> getSearchedMovie(String searchText) async {
    endPoint = 'search/movie?query=$searchText';
    final url = '$baseUrl$endPoint';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhODliYTBmNDkwMWZjZWU0MzgyZGU0Mjc3NDVkNGNlNCIsIm5iZiI6MTc0NTI5NjEwMi41ODcwMDAxLCJzdWIiOiI2ODA3MWFlNmFjMDJkNDQwN2JhYWVlMzUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.fVbsGnhUYaJl1gaGbNdr-HvKEwOqA1LvyvyYjoW7tWw',
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log('success');
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  search movie ');
  }
}
