
import 'package:movies_watchlist/HomeTab/Data/Response/topRatedOrPopularResponse.dart';

import '../Data/Response/upComingResponse.dart';

abstract class homeTabStates {}

class HomeTabInitialState extends homeTabStates {}

class HomeTopRatedTabLoadinglState extends homeTabStates {}

class HomeTopRatedTabErrorState extends homeTabStates {
  String errorMessage;
  HomeTopRatedTabErrorState({required this.errorMessage});
}

class HomeTobRatedTabSuccsesState extends homeTabStates {
  TopRatedOrPopularResponse topRatedResponse;
  HomeTobRatedTabSuccsesState({required this.topRatedResponse});
}

class HomePopularTabLoadingState extends homeTabStates {}

class HomePopularTabErrorState extends homeTabStates {
  String errorMessage;
  HomePopularTabErrorState({required this.errorMessage});
}

class HomePopularTabSuccsesState extends homeTabStates {
  TopRatedOrPopularResponse popularResponse;
  HomePopularTabSuccsesState({required this.popularResponse});
}

class HomeUpComingTabLoadingState extends homeTabStates {}

class HomeUpComingTabErrorstate extends homeTabStates {
  String errorMessage;
  HomeUpComingTabErrorstate({required this.errorMessage});
}

class HomeUpComingTabSuccsesState extends homeTabStates {
  UpComingResponse upComingResponse;
  HomeUpComingTabSuccsesState({required this.upComingResponse});
}
