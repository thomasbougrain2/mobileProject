import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        actions: <Widget>[
          SvgPicture.asset(
            'assets/svg/astronaut.svg',
            width: 30,
            height: 30,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Bienvenue !',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildSectionTitle(context, 'Séries populaires'),
            _buildHorizontalList(), // À remplir avec vos données pour les séries
            _buildSectionTitle(context, 'Comics populaires'),
            _buildHorizontalList(), // À remplir avec vos données pour les comics
            _buildSectionTitle(context, 'Films populaires'),
            _buildHorizontalList(), // À remplir avec vos données pour les films
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/navbar_home.svg'),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/navbar_series.svg'),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/navbar_comics.svg'),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/navbar_movies.svg'),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/navbar_search.svg'),
            label: 'Recherche',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            child: Text('Voir plus'),
            onPressed: () {
              // Naviguer vers l'écran correspondant
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList() {
    // Remplissez cette méthode avec vos données et ajustez la mise en page selon vos besoins
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10, // le nombre d'éléments dans la liste
        itemBuilder: (context, index) {
          // Vous allez générer des cartes avec des images, des titres, etc.
          return Card(
            child: Image.network(
              'https://placekitten.com/200/200', // Remplacez par vos URLs d'images
              width: 160,
              height: 200,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
