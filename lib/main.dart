import 'package:flutter/material.dart';
import 'package:project_2/model/newsdata.dart';
import 'package:project_2/pages/stories.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NewsData()..fetchData(),
      child: const MaterialApp(
        home: StoriesPage(),
      ),
    ),
  );
}
