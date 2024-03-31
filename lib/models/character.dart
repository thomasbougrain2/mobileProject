class Character {
  final String name;
  final String description;
  final String imageUrl;
  final List<String> series; // Liste des séries dans lesquelles le personnage a joué
  final List<String> movies; // Liste des films dans lesquels le personnage a joué
  final List<String> comics; // Liste des films dans lesquels le personnage a joué


  Character({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.series,
    required this.movies,
    required this.comics,

  });
}
