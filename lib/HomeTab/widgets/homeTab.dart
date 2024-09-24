import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppColors.dart';
import '../HomeTabViewModel/homeTabStates.dart';
import '../HomeTabViewModel/homeTabViewModel.dart';
import 'TopRatedSection.dart';
import 'UpComingSection.dart';
import 'movieCard.dart';

class Hometab extends StatefulWidget {
  static const String routeName = "homeTab";
  const Hometab({Key? key}) : super(key: key);

  @override
  State<Hometab> createState() => _HometabState();
}

class _HometabState extends State<Hometab> {
  Hometabviewmodel viewModel = Hometabviewmodel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Hometabviewmodel, homeTabStates>(
        bloc: viewModel
          ..getAllTopRated()
          ..getAllPopular()
          ..getAllUpComing(),
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: AppColors.blackColor,
            appBar: AppBar(
              backgroundColor: AppColors.blackColor,
              toolbarHeight: 5.h, // Reduced toolbar height
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Popular Section
                    Container(
                      height: 275.h, // Define height for Popular section
                      alignment: Alignment.center,
                      child: viewModel.popularList == null ||
                              viewModel.popularList!.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors
                                    .whiteColorText, // Customize the color
                              ),
                            )
                          : CarouselSlider.builder(
                              itemCount: viewModel.popularList!.length,
                              itemBuilder: (context, index, realIndex) {
                                return MovieCard(
                                  moviecard: viewModel.popularList![
                                      index], // Pass each movie to MovieCard
                                );
                              },
                              options: CarouselOptions(
                                height: 275
                                    .h, // Use the same height as the container
                                enlargeCenterPage: true,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 2),
                                viewportFraction: 0.8,
                                aspectRatio: 16 / 9,
                                initialPage: 0,
                              ),
                            ),
                    ),

                    // SizedBox(height: 5.h),

                    // Upcoming Section
                    Container(
                      height: 215.h, // Define height for Upcoming section
                      alignment: Alignment.center,
                      child: viewModel.upComingList == null ||
                              viewModel.upComingList!.isEmpty
                          ? CircularProgressIndicator(
                              color: AppColors.whiteColorText,
                            )
                          : upComingSection(
                              name: 'New Releases',
                              upComingList: viewModel.upComingList!,
                            ),
                    ),
                    SizedBox(height: 25.h),

                    // Top Rated Section
                    Container(
                      height: 240.h,
                      color: AppColors
                          .greySearchBarColor, // Ensure this color is visible with your content
                      alignment: Alignment.center,
                      child: viewModel.topRatedList == null ||
                              viewModel.topRatedList!.isEmpty
                          ? CircularProgressIndicator(
                              color: AppColors.whiteColorText,
                            )
                          : TopRatedSection(
                              name: 'Recommended',
                              topRatedList: viewModel.topRatedList!,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
