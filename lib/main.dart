import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/series/series_bloc.dart'; // Assurez-vous d'importer le bon fichier
import 'blocs/movie/movie_bloc.dart';
import 'blocs/comic/comic_bloc.dart';
import 'blocs/navigation/navigation_bloc.dart';
import 'screens/main_screen.dart';
import 'services/api_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(ApiService()),
        ),
        BlocProvider<SeriesBloc>(
          create: (context) => SeriesBloc(ApiService()),
        ),
        // Ajouter le BlocProvider pour ComicBloc ici
        BlocProvider<ComicBloc>(
          create: (context) => ComicBloc(ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Votre Application',
        theme: AppTheme.theme,
        home: MainScreen(),
      ),
    );
  }
}

