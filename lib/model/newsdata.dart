import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewsData with ChangeNotifier{
  final Map<dynamic, String> _map = {};

  Map get map => _map;

  Future<void> get fetchData async{
    final response = await get(Uri.parse('https://dl.dropbox.com/s/tifvv3vx91wfnmg/stories.json?dl=0'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      'Network Connection issue';
    }
    notifyListeners();
  }
}