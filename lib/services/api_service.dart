import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/series.dart';
import '../models/character.dart';
import '../models/comic.dart';
import '../models/episode.dart';
import '../models/person.dart';

class ApiService {
  static const String apiKey = 'd00f1b0d69e0a383e908895ced56fe9331a847bb';
  static const String baseUrl = 'https://api.formation-android.fr/comicvine';

  static Future<List<Movie>> fetchMovies() async {
    final url = Uri.parse('$baseUrl?url=movies&api_key=$apiKey&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      // Limitez les résultats à 50 en utilisant la méthode sublist
      final List<dynamic> limitedData = data.length > 50 ? data.sublist(0, 50) : data;
      return limitedData.map((movieData) => Movie.fromJson(movieData)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception('Failed to load movies with status code: ${response.statusCode}');
    }
  }
  static Future<List<Series>> fetchSeries() async {
    final url = Uri.parse('$baseUrl?url=series_list&api_key=$apiKey&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      // Limit the results to 50 using the sublist method
      final List<dynamic> limitedData = data.length > 50 ? data.sublist(0, 50) : data;
      return limitedData.map((seriesData) => Series.fromJson(seriesData)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception('Failed to load series with status code: ${response.statusCode}');
    }
  }


  static Future<List<Episode>> fetchEpisodes() async {
    final url = Uri.parse('$baseUrl?url=episodes&api_key=$apiKey&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      // Limiter les résultats à 50 en utilisant la méthode sublist
      final List<dynamic> limitedData = data.length > 50 ? data.sublist(0, 50) : data;
      return limitedData.map((episodeData) => Episode.fromJson(episodeData)).toList();
    } else {
      print('La requête a échoué avec le statut: ${response.statusCode}.');
      print('Corps de la réponse: ${response.body}');
      throw Exception('Impossible de charger les épisodes avec le code d\'état: ${response.statusCode}');
    }
  }


  static Future<List<Character>> fetchCharacters() async {
    final url = '$baseUrl?url=characters&api_key=$apiKey&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((character) {
        // Récupération de la liste des séries associées à chaque personnage
        final List<dynamic> seriesData = character['series'] ?? [];
        final List<String> seriesNames =
        seriesData.map((series) => series['name'].toString()).toList();

        // Récupération de la liste des films associés à chaque personnage
        final List<dynamic> moviesData = character['movies'] ?? [];
        final List<String> moviesNames =
        moviesData.map((movie) => movie['title'].toString()).toList();

        // Récupération de la liste des comics associés à chaque personnage
        final List<dynamic> comicsData = character['comics'] ?? [];
        final List<String> comicsNames =
        comicsData.map((comic) => comic['title'].toString()).toList();

        return Character(
          name: character['name'],
          imageUrl: character['image']['medium_url'] ?? '',
          description: character['description'] ?? '',
          series: seriesNames,
          movies: moviesNames,
          comics: comicsNames,
        );
      }).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

   static Future<List<Comic>> fetchComics() async {
    final url = Uri.parse('$baseUrl?url=issues&api_key=$apiKey&format=json');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      // Limit the results to 50 using the sublist method
      final List<dynamic> limitedData = data.length > 50 ? data.sublist(0, 50) : data;
      return limitedData.map((comicData) => Comic.fromJson(comicData)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception('Failed to load comics with status code: ${response.statusCode}');
    }
  }

  // Fonction pour récupérer une liste de personnes
  static Future<List<Person>> fetchPersons(List<int> personIds) async {
    final List<Person> persons = [];

    for (final personId in personIds) {
      final url = '$baseUrl/person/$personId?api_key=$apiKey&format=json';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['results'];
        final person = Person.fromJson(jsonData);
        persons.add(person);
      } else {
        print('Failed to load person with ID: $personId');
      }
    }

    return persons;
  }




}
