import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/movie.dart';
import 'models/series.dart';

class ApiService {
  static const String apiKey = 'd00f1b0d69e0a383e908895ced56fe9331a847bb';

  static Future<List<Film>> fetchMovies() async {
    final url = 'https://api.formation-android.fr/comicvine?url=movies&api_key=$apiKey&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((movie) {
        return Film(
          title: movie['name'],
          imageUrl: movie['image']['medium_url'] ?? '',
          description: movie['description'] ?? '',
        );
      }).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<List<Serie>> fetchSeries() async {
    final url = 'https://api.formation-android.fr/comicvine?url=series&api_key=$apiKey&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((serie) {
        return Serie(
          title: serie['name'] ?? '',
          imageUrl: serie['image']['medium_url'] ?? '',
          description: serie['description'] ?? '',

        );
      }).toList();
    } else {
      throw Exception('Failed to load series');
    }
  }
}
