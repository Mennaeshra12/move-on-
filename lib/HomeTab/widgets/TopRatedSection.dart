
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_watchlist/HomeTab/widgets/topRatedItem.dart';

import '../../AppColors.dart';
import '../Data/Response/topRatedOrPopularResponse.dart';

class TopRatedSection extends StatefulWidget {
  final String? name;
  final List<MovieModel> topRatedList; // Ensure proper class name

  TopRatedSection({required this.topRatedList, required this.name});

  @override
  State<TopRatedSection> createState() => _TopRatedSectionState();
}

class _TopRatedSectionState extends State<TopRatedSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            widget.name ?? 'Recomended',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.whiteColorText),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 200.h,

          //  width: 300.w, // Wrapping GridView in a SizedBox for height
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.topRatedList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: TopRatedItem(
                  // Assuming CardItem is a widget you've defined
                  topratedorpopular:
                      widget.topRatedList[index], // Pass correct data
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
          ),
        ),
      ],
    );
  }
}
