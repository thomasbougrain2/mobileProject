import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../blocs/search/search_bloc.dart';

class Search_screen extends StatefulWidget {
  const Search_screen({Key? key}) : super(key: key);

  @override
  _Search_screenState createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {
  final TextEditingController searchController = TextEditingController();

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      context.read<SearchBloc>().add(DoSearchEvent(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Comic, film, série...',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Color(0xFF15232E),
                      ),
                      onSubmitted: _onSearchSubmitted,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search,
                        color: Color(0xFF778BA8), size: 28.0),
                    onPressed: () => _onSearchSubmitted(
                        searchController.text),
                  ),
                ],
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoadState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchResultsState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.result.entries.length,
                    itemBuilder: (context, index) {
                      final category =
                          state.result.entries.elementAt(index).key;
                      final items =
                          state.result.entries.elementAt(index).value;

                      return ExpansionTile(
                        backgroundColor: Color(0xFF15232E),
                        title: Text(category,
                            style: TextStyle(color: Colors.white, fontSize: 18.0)),
                        children: items.map((item) {
                          final String imageUrl = item['imageUrl'] ?? '';
                          final String name = item['name'] ?? 'Inconnu';

                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            leading: imageUrl.isNotEmpty
                                ? Image.network(imageUrl, width: 50, height: 50)
                                : SizedBox(
                                width: 50,
                                height: 50),
                            title: Text(name,
                                style: TextStyle(color: Colors.white, fontSize: 16.0)),
                            onTap: () {

                            },
                          );
                        }).toList(),
                      );
                    },
                  );
                } else if (state is SearchErrorState) {
                  return Center(
                    child: Text(state.error,
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Saisissez une recherche pour trouver un comics, film, série ou personnage.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF778BA8),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
