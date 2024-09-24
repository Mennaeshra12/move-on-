import 'package:flutter_bloc/flutter_bloc.dart';

import '../dataBrowser/apiBrowserManger.dart';
import '../dataBrowser/responseBrowser/browserResponse.dart';
import 'browserTabStates.dart';

class browserTabViewModel extends Cubit<browserTabStates> {
  browserTabViewModel() : super(browserTabInitialState());
  List<Browser>? browserList;

  void getAllMovieList() async {
    try {
      emit(browserTabLoadinglState());
      var response = await ApibrowserManger.getAllMovielList();
      if (response.status_message == "fail") {
        emit(browserTabErrorState(errorMessage: response.message!));
      } else {
        browserList = response.genres ?? [];
        emit(browserTabSuccsesState(browserResponse: response));
      }
    } catch (e) {
      emit(browserTabErrorState(errorMessage: e.toString()));
    }
  }
}
