// models/series.dart
class Series {
  final int id;
  final String title;
  final String imageUrl;
  final String description;

  Series({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'] as int,
      title: json['name'] ?? 'Titre non disponible',
      imageUrl: json['image']['medium_url'] ?? '',
      description: json['description'] ?? 'Description non disponible',
    );
  }
}
