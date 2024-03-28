import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poject/screens/movie_list_screen.dart';
import 'package:poject/screens/series_list_screen.dart';
import '../blocs/navigation/navigation_bloc.dart';
import '../blocs/navigation/navigation_event.dart';
import '../blocs/navigation/navigation_state.dart';

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
    }
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
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
                .toList(growable: false),
            onTap: (index) {
              final event = _mapIndexToNavigationEvent(index);
              context.read<NavigationBloc>().add(event);
            },
          ),
        );
      },
    );
  }

  Widget _getContent(NavigationState state) {
    if (state is HomeNavigationState) {
      return const Center(child: Text('Home'));
    } else if (state is ComicsListNavigationState) {
      return const Center(child: Text('Comics'));
    } else if (state is SeriesListNavigationState) {
      return SeriesPage();
    } else if (state is MoviesListNavigationState) {
      return MoviesPage();
    } else if (state is CharacterDetailsNavigationState) {
      return const Center(child: Text('Character'));
    } else {
      return const SizedBox();
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
