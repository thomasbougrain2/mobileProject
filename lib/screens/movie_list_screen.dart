import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '/models/movie.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = ApiService.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Films'),
        backgroundColor: Color(0xFF15232E), // Adapter à la couleur du thème
      ),
      body: FutureBuilder<List<Movie>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final movies = snapshot.data ?? [];
            return ListView.separated(
              itemCount: movies.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Card(
                  color: const Color(0xFF1E3243), // Adapter à la couleur du thème
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4), // Bord arrondi pour l'image
                      child: movie.imageUrl != null
                          ? Image.network(movie.imageUrl!, width: 50, height: 100, fit: BoxFit.cover)
                          : SizedBox(width: 50, height: 100, child: Placeholder()),
                    ),
                    title: Text(movie.title ?? 'Titre non disponible', style: TextStyle(color: Colors.white)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          movie.description ?? 'Description non disponible',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        // Vous pouvez ajouter plus d'informations ici, comme la durée et l'année
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      backgroundColor: Color(0xFF15232E), // Couleur de fond du Scaffold
    );
  }
}
