// main_screen.dart

import 'package:flutter/material.dart';
import '/models/movie.dart';
import '/models/series.dart';
import 'movie_list_screen.dart';
import 'series_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTabPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabPosition,
        type: BottomNavigationBarType.fixed,
        items: AppTabs.values
            .map((tab) =>
            BottomNavigationBarItem(label: tab.label, icon: Icon(tab.icon)))
            .toList(growable: false),
        onTap: (int position) {
          setState(() {
            _currentTabPosition = position;
          });
        },
      ),
    );
  }

  Widget _getContent() {
    switch (AppTabs.values[_currentTabPosition]) {
      case AppTabs.home:
        return const Center(child: Text('Home'));
      case AppTabs.comics:
        return const Center(child: Text('Comics'));
      case AppTabs.series:
        return SeriesPage(); // Afficher la page des séries
      case AppTabs.movies:
        return MoviesPage(); // Afficher la page des films
      case AppTabs.search:
        return const Center(child: Text('Recherche'));
      default:
        return const SizedBox(); // Par défaut, renvoyer un widget vide
    }
  }
}

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
        return Icons.home;
      case AppTabs.comics:
        return Icons.book;
      case AppTabs.series:
        return Icons.tv;
      case AppTabs.movies:
        return Icons.movie;
      case AppTabs.search:
        return Icons.search;
    }
  }
}
