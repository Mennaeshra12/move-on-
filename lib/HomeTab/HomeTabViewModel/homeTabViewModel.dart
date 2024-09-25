
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_watchlist/HomeTab/Data/Response/topRatedOrPopularResponse.dart';
import 'package:movies_watchlist/HomeTab/Data/Response/upComingResponse.dart';

import '../Data/apiManger.dart';
import 'homeTabStates.dart';

class Hometabviewmodel extends Cubit<homeTabStates> {
  Hometabviewmodel() : super(HomeTabInitialState());
  List<MovieModel>? popularList;
  List<MovieModel>? topRatedList;
  List<upComing>? upComingList;
  void getAllTopRated() async {
    try {
      emit(HomeTopRatedTabLoadinglState());
      var response = await ApiManager.getAllTopRated();
      if (response.status_message == "fail") {
        emit(HomeTopRatedTabErrorState(errorMessage: response.message!));
      } else {
        topRatedList = response.results ?? [];
        emit(HomeTobRatedTabSuccsesState(topRatedResponse: response));
      }
    } catch (e) {
      emit(HomeTopRatedTabErrorState(errorMessage: e.toString()));
    }
  }

  void getAllPopular() async {
    try {
      emit(HomePopularTabLoadingState());
      var response = await ApiManager.getAllPopular();
      if (response.status_message == "fail") {
        emit(HomePopularTabErrorState(errorMessage: response.message!));
      } else {
        popularList = response.results ?? [];
        emit(HomePopularTabSuccsesState(popularResponse: response));
      }
    } catch (e) {
      emit(HomePopularTabErrorState(errorMessage: e.toString()));
    }
  }

  void getAllUpComing() async {
    try {
      emit(HomeUpComingTabLoadingState());
      var response = await ApiManager.getAllUpComing();
      if (response.status_message == "fail") {
        emit(HomeUpComingTabErrorstate(errorMessage: response.message!));
      } else {
        upComingList = response.results ?? [];
        emit(HomeUpComingTabSuccsesState(upComingResponse: response));
      }
    } catch (e) {
      emit(HomeUpComingTabErrorstate(errorMessage: e.toString()));
    }
  }
}
