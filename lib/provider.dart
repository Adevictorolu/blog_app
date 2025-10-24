


import 'package:flutter/widgets.dart';

class Providerstate with ChangeNotifier{
  String _name = 'Ademola Victor';
  void changeDate(String data){
    _name = data;
    notifyListeners();
  }
  String get name => _name;
}