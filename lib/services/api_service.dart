import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/series.dart';
import '../models/character.dart';
import '../models/comic.dart';

class ApiService {
  static const String apiKey = 'd00f1b0d69e0a383e908895ced56fe9331a847bb';
  static const String baseUrl = 'https://api.formation-android.fr/comicvine';

  static Future<List<Movie>> fetchMovies() async {
    // Remarquez comment l'URL est construite ici avec les paramètres encodés.
    final url = Uri.parse('$baseUrl?url=movies&api_key=$apiKey&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((movieData) => Movie.fromJson(movieData)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception('Failed to load movies with status code: ${response.statusCode}');
    }
  }

  static Future<List<Series>> fetchSeries() async {
    final url = '$baseUrl?url=series_list&api_key=$apiKey&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((serie) {
        return Series(
          title: serie['name'] ?? '',
          imageUrl: serie['image']['medium_url'] ?? '',
          description: serie['description'] ?? '',
        );
      }).toList();
    } else {
      throw Exception('Failed to load series');
    }
  }

  static Future<List<Character>> fetchCharacters() async {
    final url = '$baseUrl?url=characters&api_key=$apiKey&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((character) {
        return Character(
          name: character['name'],
          imageUrl: character['image']['medium_url'] ?? '',
          description: character['description'] ?? '',
        );
      }).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  static Future<List<Comic>> fetchComics() async {
    final url = '$baseUrl?url=issues&api_key=$apiKey&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((comic) {
        return Comic(
          title: comic['name'],
          imageUrl: comic['image']['medium_url'] ?? '',
          description: comic['description'] ?? '',
        );
      }).toList();
    } else {
      throw Exception('Failed to load comics');
    }
  }
}
