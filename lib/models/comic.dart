// models/comic.dart
class Comic {
  final int id;
  final String name;
  final String imageUrl;
  final String deck;
  final String coverDate;
  final int issueNumber;
  final List<String> characters;
  final List<String> authors; // Ajout de la liste d'auteurs

  Comic({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.deck,
    required this.coverDate,
    required this.issueNumber,
    required this.characters,
    required this.authors, // Initialisation de la liste d'auteurs
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Titre non disponible',
      imageUrl: json['image']['medium_url'] as String? ?? '',
      deck: json['deck'] as String? ?? 'Phrase non disponible',
      coverDate: json['cover_date'] as String? ?? '',
      issueNumber: json['issue_number'] as int? ?? 0,
      characters: (json['characters'] as List<dynamic>?)
          ?.map((character) => character['name'] as String)
          .toList() ?? [],
      authors: [], // Initialisation de la liste d'auteurs
    );
  }
}
