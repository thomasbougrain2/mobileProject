class Character {
  final String name;
  final String description;
  final String imageUrl;

  Character({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] as String? ?? 'Unknown',
      imageUrl: json['image']?['medium_url'] as String? ??
          'https://example.com/default_character.png', // URL par défaut pour les images
      description: json['description'] as String? ?? 'No biography available',
    );
  }

}
