import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/navigation/navigation_bloc.dart';
import '../blocs/navigation/navigation_event.dart';
import '../blocs/navigation/navigation_state.dart';
import 'movie_details_screen.dart';
import 'movie_list_screen.dart';
import 'series_list_screen.dart';
import 'character_details_screen.dart'; // Assurez-vous que vous avez ce fichier

enum AppTabs {
  home,
  comics,
  series,
  movies,
  search,
}

extension AppTabsExtension on AppTabs {
  String get label {
    switch (this) {
      case AppTabs.home:
        return 'Accueil';
      case AppTabs.comics:
        return 'Comics';
      case AppTabs.series:
        return 'Séries';
      case AppTabs.movies:
        return 'Films';
      case AppTabs.search:
        return 'Recherche';
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case AppTabs.home:
        return Icons.home_outlined;
      case AppTabs.comics:
        return Icons.library_books;
      case AppTabs.series:
        return Icons.live_tv;
      case AppTabs.movies:
        return Icons.local_movies;
      case AppTabs.search:
        return Icons.search;
      default:
        return Icons.error;
    }
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is MovieDetailsNavigationState && state.movie != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movie: state.movie),
            ),
          );
        }
        // Ajouter des gestionnaires pour d'autres états de navigation si nécessaire
      },
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: _getContent(state),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex(state),
              type: BottomNavigationBarType.fixed,
              items: AppTabs.values
                  .map((tab) => BottomNavigationBarItem(
                label: tab.label,
                icon: Icon(tab.icon),
              ))
                  .toList(),
              onTap: (index) {
                final event = _mapIndexToNavigationEvent(index);
                context.read<NavigationBloc>().add(event);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getContent(NavigationState state) {
    if (state is HomeNavigationState) {
      return const Center(child: Text('Home'));
    } else if (state is ComicsListNavigationState) {
      // Assurez-vous que la classe pour cet écran est correctement définie et importée.
      return const Center(child: Text('Comics List'));
    } else if (state is SeriesListNavigationState) {
      return SeriesPage();  // Utilisation du bon nom de classe
    } else if (state is MoviesListNavigationState) {
      return MoviesPage();  // Le widget pour l'écran de liste de films
    } else if (state is CharacterDetailsNavigationState) {
      // Pour naviguer vers la liste de tous les personnages
      return AllCharactersScreen();  // Assurez-vous que vous avez importé AllCharactersScreen
    } else {
      return const SizedBox.shrink();
    }
  }

  int _currentIndex(NavigationState state) {
    if (state is HomeNavigationState) {
      return AppTabs.home.index;
    } else if (state is ComicsListNavigationState) {
      return AppTabs.comics.index;
    } else if (state is SeriesListNavigationState) {
      return AppTabs.series.index;
    } else if (state is MoviesListNavigationState) {
      return AppTabs.movies.index;
    } else if (state is CharacterDetailsNavigationState) {
      return AppTabs.search.index;
    } else {
      return 0;
    }
  }

  NavigationEvent _mapIndexToNavigationEvent(int index) {
    switch (index) {
      case 0:
        return NavigateToHomeEvent();
      case 1:
        return NavigateToComicsListEvent();
      case 2:
        return NavigateToSeriesListEvent();
      case 3:
        return NavigateToMoviesListEvent();
      case 4:
        return NavigateToCharacterDetailsEvent();
      default:
        return NavigateToHomeEvent();
    }
  }
}
