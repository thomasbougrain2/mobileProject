class Person {
  final int id;
  final String name;
  final String imageUrl;
  final String deck;

  Person({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.deck,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image']['medium_url'],
      deck: json['deck'],
    );
  }
}
