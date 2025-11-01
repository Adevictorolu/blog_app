import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsData with ChangeNotifier {
  final Map<dynamic, dynamic> _map = {};

  Map<dynamic, dynamic> get map => _map;

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dl.dropbox.com/s/tifvv3vx91wfnmg/stories.json?dl=0'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        _map.clear(); // optional
        _map.addAll(data); // store data inside the map

        notifyListeners(); // tell UI to update
      } else {
        debugPrint("Network Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("ERROR FETCHING DATA: $e");
    }
  }
}
