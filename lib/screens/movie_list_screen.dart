// screens/movie_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movie/movie_bloc.dart';
import '../blocs/navigation/navigation_bloc.dart';
import '/models/movie.dart';
import 'movie_details_screen.dart';
import '../blocs/navigation/navigation_bloc.dart';
import '../blocs/navigation/navigation_event.dart';

class MoviesPage extends StatelessWidget {
  MoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Émettre un événement pour charger les films au démarrage
    context.read<MovieBloc>().add(LoadMovies());

    return Scaffold(
      appBar: AppBar(
        title: Text('Films'),
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
                return Card(
                  color: const Color(0xFF1E3243),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(movie.imageUrl, width: 50, height: 100, fit: BoxFit.cover),
                    ),
                    title: Text(movie.title, style: TextStyle(color: Colors.white)),
                    subtitle: Text('${movie.runtime} minutes | ${movie.year}', style: const TextStyle(color: Colors.grey)),
                    onTap: () {
                      context.read<MovieBloc>().add(MovieSelected(movie));
                      context.read<NavigationBloc>().add(NavigateToMovieDetailsEvent(movie: movie));  // S'assurer que cette ligne est correcte
                    },
                  ),
                );
              },
            );
          } else if (state is MoviesLoadFailure) {
            return Center(child: Text('Erreur: ${state.errorMessage}'));
          }
          return SizedBox.shrink(); // State initial et autres cas non gérés
        },
      ),
      backgroundColor: Color(0xFF15232E),
    );
  }
}
