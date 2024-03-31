import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  CharacterDetailsScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              character.imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              character.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Button Text'),
            ),
          ],
        ),
      ),
    );
  }
}

class AllCharactersScreen extends StatefulWidget {
  @override
  _AllCharactersScreenState createState() => _AllCharactersScreenState();
}

class _AllCharactersScreenState extends State<AllCharactersScreen> {
  late Future<List<Character>> futureCharacters;

  @override
  void initState() {
    super.initState();
    futureCharacters = ApiService.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Characters'),
      ),
      body: Center(
        child: FutureBuilder<List<Character>>(
          future: futureCharacters,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Character> characters = snapshot.data!;
              return ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  Character character = characters[index];
                  return ListTile(
                    title: Text(character.name),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetailsScreen(character: character),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
