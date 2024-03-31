class Episode {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String airDate;
  final String siteDetailUrl;
  final String episodeNumber;


  Episode({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.airDate,
    required this.siteDetailUrl,
    required this.episodeNumber,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] as int,
      name: json['name'] ?? 'Nom non disponible',
      imageUrl: json['image']['medium_url'] ?? '',
      description: json['description'] ?? 'Description non disponible',
      airDate: json['air_date'] ?? 'Date non disponible',
      siteDetailUrl: json['site_detail_url'] ?? '',
      episodeNumber: json['episode_number'] ?? '',
    );
  }
}
