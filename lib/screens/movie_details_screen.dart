import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/character.dart';
import '../services/api_service.dart';

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
            FutureBuilder<List<Character>>(
              future: ApiService.fetchCharacters(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<Character>? characters = snapshot.data;
                  return ListView.builder(
                    itemCount: characters?.length ?? 0,
                    itemBuilder: (context, index) {
                      final character = characters![index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(character.imageUrl),
                        ),
                        title: Text(character.name),
                      );
                    },
                  );
                }
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
