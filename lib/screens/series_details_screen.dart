import 'package:flutter/material.dart';
import '../models/series.dart'; // Make sure to use the correct Series model

class SeriesDetailsScreen extends StatelessWidget {
  final Series series;

  SeriesDetailsScreen({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Adjust the number of tabs if necessary
      child: Scaffold(
        appBar: AppBar(
          title: Text(series.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Synopsis'),
              // You can add or remove tabs based on the information available for series
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Only one tab view for Synopsis is shown here as an example
            SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Text(series.description),
            ),
            // Add more TabViews for other information if available
          ],
        ),
      ),
    );
  }
}
