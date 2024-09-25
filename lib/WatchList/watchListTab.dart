import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_watchlist/AppColors.dart';
import 'package:movies_watchlist/HomeTab/Data/Response/topRatedOrPopularResponse.dart';
import 'package:movies_watchlist/WatchList/Widgets/wishlist_movie_item.dart';
import 'package:movies_watchlist/firebase_utils.dart';
import 'package:movies_watchlist/homeScreen/home_screen.dart';


class WatchListTab extends StatelessWidget {
  static const String routeName = "watch_list";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Wishlist',
            style: TextStyle(
              fontFamily: 'Inter',
              color: AppColors.whiteColorText,
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot<MovieModel>>(
              stream: FirebaseUtils.getRealTimeDataFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.error.toString()),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                var moviesList = snapshot.data?.docs
                    .map((element) => element.data())
                    .toList() ??
                    [];
                print('MoviesList: ${moviesList.length}');
                return (moviesList.isEmpty)
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset('assets/images/search_body.png'),
                    const SizedBox(height: 5),
                    const Text(
                      "No Movies Found",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.greySearchBarColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
                    : ListView.builder(
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, HomeScreen.routeName,
                            arguments: moviesList[index]);
                      },
                      child:
                      WatchlistMovieItem(model: moviesList[index])),
                  itemCount: moviesList.length,
                  padding: EdgeInsets.zero,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}




