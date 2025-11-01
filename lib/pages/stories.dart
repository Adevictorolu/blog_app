import 'package:flutter/material.dart';
import 'package:project_2/model/newsdata.dart';
import 'package:provider/provider.dart';

class StoriesPage extends StatefulWidget {
  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<NewsData>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<NewsData>(context);

    if (newsData.map.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Stories")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final stories = newsData.map["stories"]; // <-- depends on JSON structure

    return Scaffold(
      appBar: AppBar(title: const Text("Stories")),
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return ListTile(
            title: Text(story["title"]),
            subtitle: Text(story["author"]),
            leading: Image.network(story["imageUrl"]),
          );
        },
      ),
    );
  }
}
