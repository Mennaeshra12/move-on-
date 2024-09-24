import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BrowserScreen/Widgets/browserTabScreen.dart';
import '../../HomeTab/widgets/homeTab.dart';
import '../../SerchScreen/Widgets/searchSceenTab.dart';
// import '../../WatchList/Widgets/watchListTab.dart';
import 'homeScreenStates.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  HomeScreenViewModel() : super(HomeInitialstate());
  int selectIndex = 0;

  // Define the list of tabs here
  final List<Widget> tabs = [
    Hometab(),
    Searchsceentab(),
    BrowserTabScreen(),
    // WatchListWidget()
  ];
  void channgeSelecedIndex(int newIndex) {
    emit(HomeInitialstate());
    selectIndex = newIndex;
    emit(ChangeSelectedIndexState());
  }
}
