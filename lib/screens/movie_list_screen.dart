import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '/models/movie.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late Future<List<Film>> _moviesFuture;

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
      ),
      body: FutureBuilder<List<Film>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final movies = snapshot.data ?? [];
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie.title ?? 'Titre non disponible'),
                  subtitle: Text(movie.description ?? 'Description non disponible'),
                  leading: movie.imageUrl != null
                      ? Image.network(movie.imageUrl!)
                      : Placeholder(), // Remplacer par un widget par défaut si l'URL de l'image est manquante
                );
              },
            );
          }
        },
      ),
    );
  }
}
