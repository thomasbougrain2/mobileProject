// models/movie.dart
class Movie {
  final String title;
  final String imageUrl;
  final String runtime; // Changé en String
  final String release_date;
  final String description;
  final List<String> characters;
  final int boxOfficeRevenue;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.runtime, // Changé en String
    required this.release_date,
    required this.description,
    required this.characters,
    required this.boxOfficeRevenue,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['name'] ?? 'Titre non disponible',
      imageUrl: json['image']['medium_url'] ?? '',
      runtime: json['runtime'] ?? '0', // Assignation directe en tant que String
      release_date: json['release_date'] ?? '',
      description: json['description'] ?? 'Description non disponible',
      characters: json['characters'] != null ? List<String>.from((json['characters'] as List).map((character) => character['name'] as String)) : [],
      boxOfficeRevenue: int.tryParse(json['box_office_revenue'] ?? '0') ?? 0,
    );
  }

  String get year {
    // Nous essayons d'extraire l'année à partir de la date complète au format "yyyy-MM-dd hh:mm:ss"
    // Cela suppose que release_date est dans ce format.
    // Nous divisons la chaîne en utilisant "-" comme séparateur et prenons la première partie.
    return release_date.isNotEmpty ? release_date.split('-')[0] : 'Inconnu';
  }

// Reste de votre classe...
}
