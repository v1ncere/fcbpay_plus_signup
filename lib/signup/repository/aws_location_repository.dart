import 'dart:convert';

import 'package:http/http.dart' as http;

import '../signup.dart';

class AWSLocationRepository {

  Future<List<PlaceSuggestion>> searchPlaces(String query) async {
    final url = Uri.https(
      'yfvzibqi21.execute-api.ap-southeast-2.amazonaws.com',
      '/default/fcbPayPlusPlaces',
      { "query": query }
    );
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch suggestions.");
    }
    
    final data = jsonDecode(response.body);
    return (data as List).map((e) => PlaceSuggestion.fromJson(e)).toList();
  }
}