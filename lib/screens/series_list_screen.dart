import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/series/series_bloc.dart'; // Vous devez avoir créé ce bloc
import '../models/series.dart';
import 'series_details_screen.dart'; // Vous devez avoir créé cet écran

class SeriesPage extends StatelessWidget {
  SeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cela déclenchera le chargement des séries
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
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              serie.imageUrl,
                              width: 128.86,
                              height: 118,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                              child: Text(
                                serie.title,
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
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
