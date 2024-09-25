import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_watchlist/HomeTab/Data/Response/topRatedOrPopularResponse.dart';
import 'package:movies_watchlist/dialog_utils.dart';

class FirebaseUtils {
  // get movies collection reference
  static CollectionReference<MovieModel> getMoviesCollection() {
    return FirebaseFirestore.instance
        .collection("watch_list")
        .withConverter<MovieModel>(
        fromFirestore: (snapshot, _) => MovieModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson());
  }

  // add movie object to firestore
  static Future addMovieToFirestore(MovieModel movie, BuildContext context) async {
    DialogUtils.showLoading(context, "Adding to watch list.....");
    await Future.delayed(const Duration(seconds: 2));

    try {
      CollectionReference<MovieModel> movieCollection = getMoviesCollection();
      DocumentReference<MovieModel> docRef = movieCollection.doc("${movie.id}");
      docRef.set(movie);

      DialogUtils.hideLoading(context);

      DialogUtils.showMessage(
          context: context,
          content: "Movie added to watch List.",
          title: "Success",
          posActionName: "ok");
    } catch (e) {
      DialogUtils.hideLoading(context);

      DialogUtils.showMessage(
          context: context,
          content: e.toString(),
          title: "Error",
          negActionName: "ok");
    }
  }

  // delete movie object from firestore
  static Future<void> deleteMovieFromFirebase(
      MovieModel movie, BuildContext context) async {
    DialogUtils.showLoading(context, "Removing from watch list....");
    await Future.delayed(const Duration(seconds: 2));

    try {
      DialogUtils.hideLoading(context);

      getMoviesCollection().doc("${movie.id}").delete();

      DialogUtils.showMessage(
          context: context,
          content: "Movie deleted from watch List.",
          title: "Success",
          posActionName: "ok");
    } catch (e) {
      DialogUtils.hideLoading(context);

      DialogUtils.showMessage(
          context: context,
          content: e.toString(),
          title: "Error",
          posActionName: "ok");
    }
  }
  static Stream<QuerySnapshot<MovieModel>> getRealTimeDataFromFirestore() {
    var snapshot = getMoviesCollection().snapshots();
    return snapshot;
  }

  static Stream<QuerySnapshot<MovieModel>> readMovieFromFirestore() {
    var querySnapshot = getMoviesCollection().snapshots();
    return querySnapshot;
  }

  static Future<bool> existMovieInFirestore(MovieModel movie) async {
    var querySnapshot = await getMoviesCollection().doc("${movie.id}").get();
    return querySnapshot.exists;
  }
}
