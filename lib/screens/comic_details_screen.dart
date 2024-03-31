import 'package:flutter/material.dart';
import '../models/comic.dart';
import '../models/character.dart';


class ComicDetailsScreen extends StatelessWidget {
  final Comic comic;

  ComicDetailsScreen({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(comic.imageUrl),
            SizedBox(height: 16),
            Text(
              comic.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Date de sortie: ${comic.coverDate}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Numéro de série: ${comic.issueNumber}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Histoire:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              comic.deck.isNotEmpty ? comic.deck : 'Pas d\'information sur l\'histoire.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Auteurs:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              comic.authors.isNotEmpty ? comic.authors.join(', ') : 'Pas d\'information sur les auteurs.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Personnages associés:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              comic.characters.isNotEmpty ? comic.characters.join(', ') : 'Pas de personnages associés.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
