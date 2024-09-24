import 'package:flutter/material.dart';

import '../../AppColors.dart';

class Searchsceentab extends StatelessWidget {
  static const String routeName = "search";
  const Searchsceentab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        toolbarHeight: 5, // Reduced toolbar height
      ),
    );
  }
}
