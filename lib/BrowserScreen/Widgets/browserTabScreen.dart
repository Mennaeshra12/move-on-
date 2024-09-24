import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppColors.dart';
import '../browserViewModel/browserTabStates.dart';
import '../browserViewModel/browserTabViewModel.dart';
import 'Browseritem.dart';

class BrowserTabScreen extends StatefulWidget {
  static const String routeName = "browser";

  BrowserTabScreen({Key? key}) : super(key: key);

  @override
  State<BrowserTabScreen> createState() => _BrowserTabScreenState();
}

class _BrowserTabScreenState extends State<BrowserTabScreen> {
  final browserTabViewModel viewModel = browserTabViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<browserTabViewModel, browserTabStates>(
      bloc: viewModel..getAllMovieList(),
      builder: (BuildContext context, browserTabStates state) {
        return Scaffold(
          backgroundColor: AppColors.blackColor,
          appBar: AppBar(
            backgroundColor: AppColors.blackColor,
            toolbarHeight: 50, // Adjusted toolbar height for visibility
          ),
          body: Container(
            margin: const EdgeInsets.all(5),
            color: AppColors.blackColor,
            child: _buildBodyContent(state), // Build content based on state
          ),
        );
      },
    );
  }

  Widget _buildBodyContent(browserTabStates state) {
    if (state is browserTabLoadinglState) {
      return const Center(
        child: CircularProgressIndicator(), // Show loading indicator
      );
    } else if (state is browserTabErrorState) {
      return Center(
        child: Text(
          state.errorMessage,
          style: TextStyle(color: Colors.red, fontSize: 18.sp),
        ),
      );
    } else if (state is browserTabSuccsesState) {
      if (viewModel.browserList == null || viewModel.browserList!.isEmpty) {
        return Center(
          child: Text(
            'No movies available',
            style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColorText),
          ),
        );
      } else {
        return _buildMovieGrid(); // Display the movie grid when data is available
      }
    }
    return const SizedBox.shrink(); // Fallback if state doesn't match
  }

  // Extract the grid view into its own method
  Widget _buildMovieGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: GridView.builder(
        itemCount: viewModel.browserList!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          mainAxisSpacing: 20, // Spacing between rows
          crossAxisSpacing: 20, // Spacing between columns
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Handle item tap if necessary
            },
            child: Browseritem(
              browser: viewModel.browserList![index], // Use null-safe access
            ),
          );
        },
      ),
    );
  }
}
