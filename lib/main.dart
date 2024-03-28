import 'package:flutter/material.dart';
import 'screens/main_screen.dart'; // Assurez-vous que le chemin est correct
import 'theme/app_theme.dart'; // Importez le fichier du thème

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/navigation/navigation_bloc.dart';
import '../screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(), // Créez une instance de votre BLoC de navigation
      child: MaterialApp(
        title: 'Votre Application',
        theme: AppTheme.theme,
        home: MainScreen(), // Assurez-vous de fournir l'écran principal de votre application
      ),
    );
  }
}
