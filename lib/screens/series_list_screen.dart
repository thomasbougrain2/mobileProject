// series_page.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '/models/series.dart';


class SeriesPage extends StatefulWidget {
  const SeriesPage({Key? key}) : super(key: key);

  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  late Future<List<Series>> _seriesFuture;

  @override
  void initState() {
    super.initState();
    _seriesFuture = ApiService.fetchSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Séries'),
      ),
      body: FutureBuilder<List<Series>>(
        future: _seriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final series = snapshot.data ?? [];
            return ListView.builder(
              itemCount: series.length,
              itemBuilder: (context, index) {
                final serie = series[index];
                return ListTile(
                  title: Text(serie.title ?? 'Titre non disponible'),
                  subtitle: Text(serie.description ?? 'Description non disponible'),
                  leading: serie.imageUrl != null
                      ? Image.network(serie.imageUrl!)
                      : Placeholder(), // Remplacer par un widget par défaut si l'URL de l'image est manquante
                );
              },
            );

          }
        },
      ),
    );
  }
}
