import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movie/movie_bloc.dart';
import '/models/movie.dart';
import 'movie_details_screen.dart';

class MoviesPage extends StatelessWidget {
  MoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(LoadMovies());

    return Scaffold(
      appBar: AppBar(
        title: Text('Films les plus populaires'),
        backgroundColor: Color(0xFF15232E),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MoviesLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MoviesLoadSuccess) {
            final movies = state.movies;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: movie),
                      ),
                    );
                  },
                  child: Container(
                    width: 359,
                    height: 153,
                    margin: const EdgeInsets.all(8),
                    child: Card(
                      color: const Color(0xFF1E3243),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 21.26,
                            left: 14,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(movie.imageUrl, width: 128.86, height: 118, fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            top: 14,
                            left: 14,
                            child: Container(
                              width: 59.36, // Largeur de la pastille orange
                              height: 40.49, // Hauteur de la pastille orange
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF8100), // Pastille orange
                                borderRadius: BorderRadius.circular(20), // Ajustez selon le design souhaité
                              ),
                              child: Text(
                                '#${movie.id}', // ID du film ici
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 25.47,
                            left: 128.86 + 14 + 14,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie.title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, color: Colors.grey, size: 20),
                                    SizedBox(width: 4),
                                    Text('${movie.runtime} minutes', style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                                    SizedBox(width: 4),
                                    Text('${movie.year}', style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is MoviesLoadFailure) {
            return Center(child: Text('Erreur: ${state.errorMessage}'));
          }
          return SizedBox.shrink(); // État initial et autres non gérés
        },
      ),
      backgroundColor: Color(0xFF15232E),
    );
  }
}
