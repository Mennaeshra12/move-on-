import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AppColors.dart';
import '../Data/Response/topRatedOrPopularResponse.dart';
import '../../firebase_utils.dart'; // Import your Firestore utility

class TopRatedItem extends StatefulWidget {
  final MovieModel? topratedorpopular;
  const TopRatedItem({super.key, required this.topratedorpopular});

  @override
  State<TopRatedItem> createState() => _TopRatedItemState();
}

class _TopRatedItemState extends State<TopRatedItem> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadIconState();
    _checkWatchlistStatus(); // Check Firestore for watchlist status
  }

  // Load the saved state of the icon from SharedPreferences
  void _loadIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _isFavorite =
            prefs.getBool('isFavorite_${widget.topratedorpopular!.id}') ??
                false;
      });
    }
  }

  // Save the icon state to SharedPreferences
  void _saveIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite_${widget.topratedorpopular!.id}', _isFavorite);
  }

  // Check if the movie is in the watchlist from Firestore
  void _checkWatchlistStatus() async {
    bool isFav = await Firestore.isMovieInWatchlist(
        widget.topratedorpopular?.title ?? '');

    if (mounted) {
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.topratedorpopular;

    if (movie == null) {
      return Center(child: Text('Movie data is unavailable'));
    }

    return SizedBox(
      width: 10.w,
      child: Container(
        width: 120.w, // Adjusted container width for screen responsiveness
        height: 160.h, // Adjusted container height for screen responsiveness
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(5), // Optional: Add rounded corners
        ),
        child: Stack(
          children: [
            // Display the main image (e.g., the movie poster from network)
            Container(
              margin: EdgeInsets.all(10.w),
              height: 110.h, // Set the image height
              width: 110.w, // Set the image width
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${widget.topratedorpopular!.posterPath ?? ""}', // Fetch poster from API
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // The tappable icon image overlaid on the main image
            Positioned(
              left: 10.w,
              top: 10.h,
              child: GestureDetector(
                onTap: () async {
                  bool newFavoriteState =
                  !_isFavorite; // Toggle the favorite state

                  if (mounted) {
                    setState(() {
                      _isFavorite = newFavoriteState;
                      _saveIconState(); // Save the state when tapped
                    });
                  }

                  if (newFavoriteState) {
                    await Firestore.addMovieToFirestore(
                      context,
                      movie.title ?? '',
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}' ??
                          '',
                      movie.releaseDate ?? "",
                    );
                  } else {
                    await Firestore.removeMovieByTitle(movie.title ?? '');
                  }
                },
                child: Image.asset(
                  _isFavorite
                      ? 'assets/images/Icon awesome-bookmark.png' // Selected state image
                      : 'assets/images/bookmark.png', // Unselected state image
                  width: 30.w, // Set the width of the icon image
                  height: 40.h, // Set the height of the icon image
                ),
              ),
            ),

            // Rating, title, and additional info overlaid on the image
            Positioned(
              top: 120.h,
              bottom: 5.h,
              left: 10.w,
              right: 10.w,
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating Row
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 18.w),
                        SizedBox(width: 4.w),
                        Text(
                          "${widget.topratedorpopular!.voteAverage ?? ""}", // Movie rating
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h), // Spacer between rows

                    // Title Row
                    Text(
                      widget.topratedorpopular!.title ?? "", // Movie title
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.whiteColorText, fontSize: 8.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h), // Spacer between rows

                    // Info Row (for release date, rating, etc.)
                    Text(
                      '${widget.topratedorpopular!.releaseDate ?? ""}  R  movieTime', // Customize this with actual runtime data if available
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColors.greyColor, fontSize: 8.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
