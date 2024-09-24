import '../dataBrowser/responseBrowser/browserResponse.dart';

abstract class browserTabStates {}

class browserTabInitialState extends browserTabStates {}

class browserTabLoadinglState extends browserTabStates {}

class browserTabErrorState extends browserTabStates {
  String errorMessage;
  browserTabErrorState({required this.errorMessage});
}

class browserTabSuccsesState extends browserTabStates {
  BrowserResponse browserResponse;
  browserTabSuccsesState({required this.browserResponse});
}
