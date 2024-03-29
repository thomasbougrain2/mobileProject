import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '/models/movie.dart';
import 'movie_details_screen.dart';

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
        backgroundColor: Color(0xFF15232E),
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
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Card(
                  color: const Color(0xFF1E3243),
                  child: InkWell( // Utilisez InkWell pour des retours visuels lors du tap
                    onTap: () {
                      print('Film ${movie.title} cliqué'); // Debug: vérifiez si cela s'affiche lors du clic sur un film
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(movie: movie),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(movie.imageUrl, width: 50, height: 100, fit: BoxFit.cover),
                      ),
                      title: Text(movie.title, style: TextStyle(color: Colors.white)),
                      subtitle: Text('${movie.runtime} minutes | ${movie.year}', style: const TextStyle(color: Colors.grey)),
                      trailing: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '#${index + 1}',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      backgroundColor: Color(0xFF15232E),
    );
  }
}
