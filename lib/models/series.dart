import 'episode.dart'; // Assurez-vous d'importer correctement la classe Episode depuis le fichier episode.dart
class Series {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final String year;
  final int episodeCount;
  final List<String> characters;
  final List<Episode> episodes; // Ajout de la liste d'épisodes

  Series({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.year,
    required this.episodeCount,
    required this.characters,
    required this.episodes,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'] as int,
      title: json['name'] ?? 'Titre non disponible',
      imageUrl: json['image']['medium_url'] ?? '',
      description: json['description'] ?? 'Description non disponible',
      year: json['start_year'].toString(),
      episodeCount: json['count_of_episodes'] as int,
      characters: (json['characters'] as List<dynamic>?)
          ?.map((character) => character['name'] as String)
          .toList() ?? [],
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((episodeJson) => Episode.fromJson(episodeJson))
          .toList() ?? [],
    );
  }
}

