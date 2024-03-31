import 'package:flutter/material.dart';
import '../models/series.dart';
import '../models/episode.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class SeriesDetailsScreen extends StatelessWidget {
  final Series series;

  SeriesDetailsScreen({Key? key, required this.series}) : super(key: key);

  String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(series.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            labelColor: Colors.white, // Couleur du texte de l'onglet sélectionné
            unselectedLabelColor: Colors.white.withOpacity(0.5),
            tabs: [
              Tab(text: 'Synopsis'),
              Tab(text: 'Personnages'),
              Tab(text: 'Épisodes'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Synopsis',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(stripHtmlIfNeeded(series.description)),
                  ],
                ),
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
            FutureBuilder<List<Episode>>(
              future: ApiService.fetchEpisodes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<Episode>? episodes = snapshot.data;
                  return ListView.builder(
                    itemCount: episodes?.length ?? 0,
                    itemBuilder: (context, index) {
                      final episode = episodes![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EpisodeDetailsScreen(episode: episode),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(episode.imageUrl),
                                radius: 24,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${episode.name} - Épisode ${episode.episodeNumber}',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    SizedBox(height: 4),
                                    Text(episode.airDate, style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EpisodeDetailsScreen extends StatelessWidget {
  final Episode episode;

  EpisodeDetailsScreen({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(episode.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(episode.imageUrl),
            SizedBox(height: 16),
            Text(
              'Date de diffusion : ${episode.airDate}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              episode.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
