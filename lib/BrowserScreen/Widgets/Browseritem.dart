import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dataBrowser/responseBrowser/browserResponse.dart';

class Browseritem extends StatefulWidget {
  final Browser? browser;
  Browseritem({super.key, required this.browser});

  @override
  State<Browseritem> createState() => _BrowseritemState();
}

class _BrowseritemState extends State<Browseritem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          width: double.infinity,
          height: 150.h, // Adjust height accordingly
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_getImageForGenre()), // Dynamically set image
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Centered text
        Center(
          child: Text(
            "${widget.browser!.name ?? "movie"}", // Fallback if browser or name is null
            style: TextStyle(
              fontSize: 32.sp, // Adjust the font size accordingly
              fontWeight: FontWeight.bold,
              color: Colors.white, // White color to contrast the background
              shadows: [
                Shadow(
                  blurRadius: 10.0.r,
                  color: Colors.black.withOpacity(0.7),
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Function to get the image based on the genre name
  String _getImageForGenre() {
    switch (widget.browser?.name?.toLowerCase()) {
      case 'comedy':
        return 'assets/images/best-comedies-1624977335.jpg'; // Path to Comedy image
      case 'horror':
        return 'assets/images/download (4).jpg'; // Path to Horror image
      case 'action':
        return 'assets/images/download (2).jpg'; // Path to Action image
      case 'animation':
        return 'assets/images/download (3).jpg'; // Path to Animation image
      default:
        return 'assets/images/download (1).jpg'; // Default image for other genres
    }
  }
}
