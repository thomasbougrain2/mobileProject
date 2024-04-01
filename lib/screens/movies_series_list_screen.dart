import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movie/movie_bloc.dart';
import '../blocs/series/series_bloc.dart';
import '../models/movie.dart';
import '../models/series.dart';
import 'movie_details_screen.dart';
import 'series_details_screen.dart';
import 'movie_list_screen.dart';
import 'series_list_screen.dart';

class MoviesSeriesPage extends StatelessWidget {
  MoviesSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(LoadMovies());
    context.read<SeriesBloc>().add(LoadSeries());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue !'),
        actions: const [
        ],
      ),
      body: ListView(
        children: [
          SectionHeader(
            title: 'Séries populaires',
            onViewMore: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SeriesPage(),
                ),
              );
            },
          ),
          BlocBuilder<SeriesBloc, SeriesState>(
            builder: (context, state) {
              if (state is SeriesLoadInProgress) {
                return const Center(
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is SeriesLoadSuccess) {
                return HorizontalList(items: state.series.take(5).toList());
              } else {
                return const Text('Erreur de chargement des séries');
              }
            },
          ),
          SectionHeader(
            title: 'Films populaires',
            onViewMore: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MoviesPage(),
                ),
              );
            },
          ),
          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MoviesLoadInProgress) {
                return const Center(
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(),
                  ),
                );               } else if (state is MoviesLoadSuccess) {
                return HorizontalList(items: state.movies.take(5).toList());
              } else {
                return const Text('Erreur de chargement des films');
              }
            },
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewMore;

  const SectionHeader({Key? key, required this.title, this.onViewMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onViewMore != null)
            TextButton(
              onPressed: onViewMore,
              child: const Text(
                'Voir plus',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  final List<dynamic> items;

  const HorizontalList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => item is Movie ? MovieDetailsScreen(movie: item) : SeriesDetailsScreen(series: item),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.imageUrl,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
      ),
    );
  }
}
