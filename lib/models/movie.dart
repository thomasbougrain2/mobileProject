class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final String runtime;
  final String releaseDate;
  final String description;
  final List<String> characters;
  final int boxOfficeRevenue;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.runtime,
    required this.releaseDate,
    required this.description,
    required this.characters,
    required this.boxOfficeRevenue,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['name'] ?? 'Titre non disponible',
      imageUrl: json['image']['medium_url'] ?? '',
      runtime: json['runtime']?.toString() ?? '0',
      releaseDate: json['release_date'] ?? '',
      description: json['description'] ?? 'Description non disponible',
      characters: (json['characters'] as List<dynamic>?)
          ?.map((character) => character['name'] as String)
          .toList() ?? [],
      boxOfficeRevenue: int.tryParse(json['box_office_revenue']?.toString() ?? '0') ?? 0,
    );
  }

  String get year {
    return releaseDate.isNotEmpty ? releaseDate.split('-')[0] : 'Inconnu';
  }
}
