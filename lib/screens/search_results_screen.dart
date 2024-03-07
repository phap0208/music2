import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../widgets/widgets.dart';

class SearchResultsScreen extends StatelessWidget {
  final List<Song> searchResults;

  const SearchResultsScreen({Key? key, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Search Results'),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return SongCard(song: searchResults[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
