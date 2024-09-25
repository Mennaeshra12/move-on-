import 'package:flutter/material.dart';
import 'package:movies_watchlist/firebase_utils.dart';

class WatchListTab extends StatefulWidget {
  static const String routeName = 'watchlisttab';

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'WatshList',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Firestore.getFavMovies(), // Call the getFavMovies function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No favorite movies found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          // Data is available
          final favMovies = snapshot.data!;
          return ListView.builder(
            itemCount: favMovies.length,
            itemBuilder: (context, index) {
              final movie = favMovies[index];
              return _buildWatchlistItem(movie);
            },
          );
        },
      ),
    );
  }

  Widget _buildWatchlistItem(Map<String, dynamic> movie) {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(right: 15),
            width: 100,
            height: 130,
            child: Image.network(
              movie['imagePath'] ?? '',
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  child: Center(child: Text('Image not available')),
                );
              },
            ),
          ),
          Container(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie['title'] ?? 'Unknown',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  movie['releaseDate'] ?? 'releaseDate unknown',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await Firestore.removeMovieByTitle(movie['title']);
              setState(() {});
            },
            icon: Icon(
              Icons.bookmark_added_outlined,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
