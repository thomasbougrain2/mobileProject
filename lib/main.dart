import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/search/search_bloc.dart';
import 'blocs/series/series_bloc.dart';
import 'blocs/movie/movie_bloc.dart';
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
        // Ajouter le BlocProvider pour SeriesBloc ici
        BlocProvider<SeriesBloc>(
          create: (context) => SeriesBloc(ApiService()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(ApiService()),
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
