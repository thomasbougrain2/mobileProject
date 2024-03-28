import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
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
        return const Center(child: Text('Home', style: TextStyle(color: Colors.white)));
      case AppTabs.comics:
        return const Center(child: Text('Comics', style: TextStyle(color: Colors.white)));
      case AppTabs.series:
        return const Center(child: Text('Séries', style: TextStyle(color: Colors.white)));
      case AppTabs.movies:
        return const Center(child: Text('Films', style: TextStyle(color: Colors.white)));
      case AppTabs.search:
        return const Center(child: Text('Recherche', style: TextStyle(color: Colors.white)));
    }
  }
}

enum AppTabs {
  home(
    'Accueil',
    Icons.home_outlined,
  ),
  comics(
    'Comics',
    Icons.library_books,
  ),
  series(
    'Séries',
    Icons.live_tv,
  ),
  movies(
    'Films',
    Icons.local_movies,
  ),
  search(
    'Recherche',
    Icons.search,
  );

  final String label;
  final IconData icon;

  const AppTabs(this.label, this.icon);
}




