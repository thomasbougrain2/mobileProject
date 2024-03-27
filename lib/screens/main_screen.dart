import 'package:flutter/material.dart';

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
    // TODO Remplacer par les écrans
    switch (AppTabs.values[_currentTabPosition]) {
      case AppTabs.home:
        return const Center(child: Text('Home'));
      case AppTabs.comics:
        return const Center(child: Text('Comics'));
      case AppTabs.series:
        return const Center(child: Text('Séries'));
      case AppTabs.movies:
        return const Center(child: Text('Films'));
      case AppTabs.search:
        return const Center(child: Text('Recherche'));
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
