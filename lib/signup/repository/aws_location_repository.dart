import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../signup.dart';

class AWSLocationRepository {

  Future<List<PlaceSuggestion>> searchPlaces(String query) async {
    final url = Uri.https(
      dotenv.get("AWS_LOCATION_API"),
      dotenv.get("AWS_LOCATION_PATH"),
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