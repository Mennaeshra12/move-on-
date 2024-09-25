import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_watchlist/splashScreen/splashScreen.dart';
import 'BrowserScreen/Widgets/browserTabScreen.dart';
import 'HomeTab/widgets/homeTab.dart';
import 'SerchScreen/Widgets/searchSceenTab.dart';
import 'homeScreen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyAkiFQ5HGGo4xXYQpc89VXkk-3ZOkH2mWs',
          appId: '1:392577934799:android:94907209d0427713969eba',
          messagingSenderId: '392577934799',
          projectId:  "movie1-7fe1a",
          storageBucket: 'movie1-7fe1a.appspot.com'))
      : await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            SplashScreen.routeName: (context) => SplashScreen(),
            Hometab.routeName: (context) => Hometab(),
            Searchsceentab.routeName: (context) => Searchsceentab(),
            BrowserTabScreen.routeName: (context) => BrowserTabScreen(),
          },
        );
      },
    );
  }
}
