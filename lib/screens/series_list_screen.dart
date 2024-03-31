import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/series/series_bloc.dart';
import '../models/series.dart';
import 'series_details_screen.dart';

class SeriesPage extends StatelessWidget {
  SeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Déclenche le chargement des séries
    context.read<SeriesBloc>().add(LoadSeries());

    return Scaffold(
      appBar: AppBar(
        title: Text('Séries les plus populaires'),
        backgroundColor: Color(0xFF15232E),
      ),
      body: BlocBuilder<SeriesBloc, SeriesState>(
        builder: (context, state) {
          if (state is SeriesLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SeriesLoadSuccess) {
            final series = state.series;
            return ListView.builder(
              itemCount: series.length,
              itemBuilder: (context, index) {
                final serie = series[index];
                return InkWell(
                  onTap: () {
                    // Assurez-vous que le nom du paramètre correspond à celui du constructeur de SeriesDetailsScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriesDetailsScreen(series: serie),
                      ),
                    );
                  },
                  child: Container(
                    width: 359,
                    height: 153,
                    margin: const EdgeInsets.all(8),
                    child: Card(
                      color: const Color(0xFF1E3243),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 21.26,
                            left: 14,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                serie.imageUrl,
                                width: 128.86,
                                height: 118,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 14,
                            left: 14,
                            child: Container(
                              width: 59.36, // Largeur de la pastille orange
                              height: 40.49, // Hauteur de la pastille orange
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF8100), // Pastille orange
                                borderRadius: BorderRadius.circular(20), // Ajustez selon le design souhaité
                              ),
                              child: Text(
                                '#${serie.id}', // ID de la série ici
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 25.47,
                            left: 128.86 + 14 + 14,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(serie.title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                                    SizedBox(width: 4),
                                    Text('${serie.year}', style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.library_books, color: Colors.grey, size: 20),
                                    SizedBox(width: 4),
                                    Text('${serie.episodeCount} épisodes', style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is SeriesLoadFailure) {
            return Center(child: Text('Erreur de chargement des séries'));
          }
          return SizedBox.shrink(); // pour les états initiaux et les autres états non gérés
        },
      ),
      backgroundColor: Color(0xFF15232E),
    );
  }
}
