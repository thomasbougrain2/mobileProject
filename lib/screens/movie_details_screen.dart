import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Nombre d'onglets
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
          // Ajoutez le bouton de retour à l'AppBar
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Retour à la page précédente dans la pile de navigation
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Synopsis'),
              Tab(text: 'Personnages'),
              Tab(text: 'Infos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Text(movie.description),
              ),
            ),
            ListView.builder(
              itemCount: movie.characters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(movie.characters[index]),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recettes au box-office: \$${movie.boxOfficeRevenue}'),
            ),
          ],
        ),
      ),
    );
  }
}
