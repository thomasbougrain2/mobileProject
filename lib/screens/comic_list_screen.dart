import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/comic/comic_bloc.dart';
import '../models/comic.dart';
import 'comic_details_screen.dart';

class ComicsPage extends StatelessWidget {
  ComicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ComicBloc>().add(LoadComics());

    return Scaffold(
      appBar: AppBar(
        title: Text('Les comics les plus populaires'),
        backgroundColor: Color(0xFF15232E),
      ),
      body: BlocBuilder<ComicBloc, ComicState>(
        builder: (context, state) {
          if (state is ComicsLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ComicsLoadSuccess) {
            final comics = state.comics;
            return ListView.builder(
              itemCount: comics.length,
              itemBuilder: (context, index) {
                final comic = comics[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComicDetailsScreen(comic: comic),
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
                                comic.imageUrl,
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
                              width: 59.36,
                              height: 40.49,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF8100),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '#${comic.id}',
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
                                Text(comic.name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text(comic.deck, style: TextStyle(color: Colors.grey)),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                                    SizedBox(width: 4),
                                    Text('${comic.coverDate}', style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.library_books, color: Colors.grey, size: 20),
                                    SizedBox(width: 4),
                                    Text('Numéro de série: ${comic.issueNumber}', style: TextStyle(color: Colors.grey)),
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
          } else if (state is ComicsLoadFailure) {
            return Center(child: Text('Erreur: ${state.errorMessage}'));
          }
          return SizedBox.shrink();
        },
      ),
      backgroundColor: Color(0xFF15232E),
    );
  }
}
