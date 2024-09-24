import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_watchlist/BrowserScreen/dataBrowser/responseBrowser/browserResponse.dart';

import 'browserEndPoint.dart';

class ApibrowserManger {
  static const String baseUrl = 'api.themoviedb.org';
  static const String apiKey = '0fac6e38b1f771ab5508dd888b0c593c';

  // Get all Top Rated movies
  static Future<BrowserResponse> getAllMovielList() async {
    Uri url = Uri.https(baseUrl, browserEndPoints.movieList, {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('API Response: $json');
        return BrowserResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  }
}
