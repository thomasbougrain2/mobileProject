import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/series.dart';
import '../models/character.dart';
import '../models/comic.dart';
import '../models/episode.dart';


class ApiService {
  static const String apiKey = '6dd5055b524038094eb25a5651b4234a7c04aebd';
  static const String baseUrl = 'https://api.formation-android.fr/comicvine';

  Future<List<T>> _fetchDataFromApi<T>(Uri url, Function fromJson) async {
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List results = data['results'] as List;
        return results.map((json) => fromJson(json)).cast<T>().toList();
      } else {
        // Gestion des erreurs
        print("Erreur de l'API");
        return [];
      }
    } catch (e) {
      print("Erreur lors de l'appel de l'API: $e");
      return [];
    }
  }

  static Future<List<Movie>> fetchMovies() async {
    final url = Uri.parse('$baseUrl?url=movies&api_key=$apiKey&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      final List<dynamic> limitedData = data.length > 50
          ? data.sublist(0, 50)
          : data;
      return limitedData.map((movieData) => Movie.fromJson(movieData)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to load movies with status code: ${response.statusCode}');
    }
  }

  static Future<List<Series>> fetchSeries() async {
    final url = Uri.parse(
        '$baseUrl?url=series_list&api_key=$apiKey&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      final List<dynamic> limitedData = data.length > 50
          ? data.sublist(0, 50)
          : data;
      return limitedData.map((seriesData) => Series.fromJson(seriesData))
          .toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to load series with status code: ${response.statusCode}');
    }
  }


  static Future<List<Episode>> fetchEpisodes() async {
    final url = Uri.parse('$baseUrl?url=episodes&api_key=$apiKey&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      final List<dynamic> limitedData = data.length > 50
          ? data.sublist(0, 50)
          : data;
      return limitedData.map((episodeData) => Episode.fromJson(episodeData))
          .toList();
    } else {
      print('La requête a échoué avec le statut: ${response.statusCode}.');
      print('Corps de la réponse: ${response.body}');
      throw Exception(
          'Impossible de charger les épisodes avec le code d\'état: ${response
              .statusCode}');
    }
  }


  static Future<List<Character>> fetchCharacters() async {
    final url = '$baseUrl?url=characters&api_key=$apiKey&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((character) {
        final List<dynamic> seriesData = character['series'] ?? [];
        final List<String> seriesNames = seriesData.map((series) => series['name'].toString()).toList();
        final List<dynamic> moviesData = character['movies'] ?? [];
        final List<String> moviesNames = moviesData.map((movie) => movie['title'].toString()).toList();

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
          id: comic['id'] as int? ?? 0,
          title: comic['name'] as String? ?? 'Unknown',
          imageUrl: comic['image']?['medium_url'] as String? ??
              'https://example.com/default_comic_cover.png',
          description: comic['description'] as String? ??
              'No description available',
          publicationDate: comic['cover_date'] as String? ?? 'Unknown',
          issueNumber: comic['issue_number'] as String? ?? 'Unknown',
          detailUrl: comic['api_detail_url'] as String? ?? '',
          volumeTitle: comic['volume']?['name'] as String? ?? 'Unknown Volume',
          volumeId: comic['volume']?['id'] as int? ?? 0,
        );
      }).toList();
    } else {
      throw Exception('Failed to load comics');
    }
  }

  Future<List<Comic>> searchComics(String searchTerm) async {
    var encodedQuery = Uri.encodeComponent(searchTerm);
    var searchUrl = Uri.parse(
        'https://comicvine.gamespot.com/api/search/?api_key=$apiKey&format=json&field_list=name,image&limit=10&resources=issue&query=$encodedQuery');
    return _fetchDataFromApi<Comic>(searchUrl, (json) => Comic.fromJson(json));
  }

  Future<List<Series>> searchSeries(String query) async {
    var encodedQuery = Uri.encodeComponent(query);
    var url = Uri.parse(
        'https://comicvine.gamespot.com/api/search/?api_key=$apiKey&format=json&field_list=name,image&limit=10&resources=series&query=$encodedQuery');
    return _fetchDataFromApi<Series>(url, (json) => Series.fromJson(json));
  }

  Future<List<Movie>> searchMovies(String query) async {
    var encodedQuery = Uri.encodeComponent(query);
    var url = Uri.parse(
        'https://comicvine.gamespot.com/api/search/?api_key=$apiKey&format=json&field_list=name,image&limit=10&resources=movie&query=$encodedQuery');
    return _fetchDataFromApi<Movie>(url, (json) => Movie.fromJson(json));
  }


  Future<List<Character>> searchCharacters(String query) async {
    var encodedQuery = Uri.encodeComponent(query);
    var url = Uri.parse(
        'https://comicvine.gamespot.com/api/search/?api_key=$apiKey&format=json&field_list=name,image&limit=10&resources=character&query=$encodedQuery');
    return _fetchDataFromApi<Character>(
        url, (json) => Character.fromJson(json));
  }
}
