class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final String runtime;
  final String releaseDate;
  final String description;
  final List<String> characters;
  final int boxOfficeRevenue;
  final String rating;
  final List<String> writers;
  final List<String> producers;
  final List<String> studios;
  final int budget;
  final int totalRevenue;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.runtime,
    required this.releaseDate,
    required this.description,
    required this.characters,
    required this.boxOfficeRevenue,
    required this.rating,
    required this.writers,
    required this.producers,
    required this.studios,
    required this.budget,
    required this.totalRevenue,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['name'] ?? 'Titre non disponible',
      imageUrl: json['image']['medium_url'] ?? '',
      runtime: json['runtime']?.toString() ?? '0',
      releaseDate: json['release_date'] ?? '',
      description: json['description'] ?? 'Description non disponible',
      characters: List<String>.from(json['characters']?.map((character) => character['name']) ?? []),
      boxOfficeRevenue: int.tryParse(json['box_office_revenue']?.toString() ?? '0') ?? 0,
      rating: json['rating'] ?? 'NR',
      writers: List<String>.from(json['writers']?.map((writer) => writer['name']) ?? []),
      producers: List<String>.from(json['producers']?.map((producer) => producer['name']) ?? []),
      studios: List<String>.from(json['studios']?.map((studio) => studio['name']) ?? []),
      budget: int.tryParse(json['budget']?.toString() ?? '0') ?? 0,
      totalRevenue: int.tryParse(json['total_revenue']?.toString() ?? '0') ?? 0,
    );
  }
  String get year {
    return releaseDate.isNotEmpty ? releaseDate.split('-')[0] : 'Inconnu';
  }


}