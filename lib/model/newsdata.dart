import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewsData with ChangeNotifier {
  Map _map = {};
  bool _error = false;
  String _errormessage = '';

  Map get map => _map;
  bool get error => _error;
  String get errormessage => _errormessage;

  Future get fetchData async {
    final response = await get(
      Uri.parse('https://dl.dropbox.com/s/tifvv3vx91wfnmg/stories.json?dl=0'),
    );
    if (response.statusCode == 200) {
      try {
        _map = jsonDecode(response.body);
        _error = false;
      } catch (e) {
        _error = true;
        _errormessage = e.toString();
        _map = {};
      }
      notifyListeners();
    } else {
      _error = true;
      _errormessage = "It could be your Internet Connection";
      _map = {};
    }
    notifyListeners();
  }
  void intialvalue(){
    _map = {};
    _error = false;
    _errormessage = '';
    notifyListeners();
  }
}
