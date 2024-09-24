import 'package:flutter/material.dart';

import '../../AppColors.dart';

class WatchListTab extends StatefulWidget {
  static const String routeName = "watch_list";

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Watch List",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 10, // movie list length
                itemBuilder: (context, index) {
                 // Replace with your movie model
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




