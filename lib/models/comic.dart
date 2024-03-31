class Comic {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final String publicationDate;
  final String issueNumber;
  final String detailUrl;
  final String volumeTitle;
  final int volumeId;

  Comic({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.description = 'Unknown',
    required this.publicationDate,
    required this.issueNumber,
    required this.detailUrl,
    required this.volumeTitle,
    required this.volumeId,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'] as int? ?? 0,
      title: json['name'] as String? ?? 'Unknown',
      imageUrl: json['image']?['medium_url'] as String? ??
          'https://example.com/default_comic_cover.png',
      description: json['description'] as String? ?? 'No description available',
      publicationDate: json['cover_date'] as String? ?? 'Unknown',
      issueNumber: json['issue_number'] as String? ?? 'Unknown',
      detailUrl: json['api_detail_url'] as String? ?? '',
      volumeTitle: json['volume']?['name'] as String? ?? 'Unknown Volume',
      volumeId: json['volume']?['id'] as int? ?? 0,
    );
  }
}
