import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.5),
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
                child: Text(stripHtmlIfNeeded(movie.description)),
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
                        title: Text(
                            character.name,
                            style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    infoRow('Classification', movie.rating),
                    infoRow('Scénaristes', movie.writers.join(', ')),
                    infoRow('Producteurs', movie.producers.join(', ')),
                    infoRow('Studios', movie.studios.join(', ')),
                    infoRow('Budget', '\$${movie.budget}'),
                    infoRow('Recettes au box-office', '\$${movie.boxOfficeRevenue}'),
                    infoRow('Recettes brutes totales', '\$${movie.totalRevenue}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
