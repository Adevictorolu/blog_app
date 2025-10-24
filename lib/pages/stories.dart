import 'package:flutter/material.dart';
import 'package:project_2/model/newsdata.dart';
import 'package:provider/provider.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsData>(
      create: (_) => NewsData(),
      child: const StoriesBody(),
    );
  }
}

class StoriesBody extends StatelessWidget {
  const StoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stories')),
      body: Consumer<NewsData>(
        builder: (context, value, child) {
          // Loading state
          if (value.map.isEmpty && !value.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Network connection error'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => value.fetchData, // retry
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Error state
          if (value.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Network connection error'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => value.fetchData, // retry
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Success: show list of stories
          final List storiesList = value.map['stories'] ?? [];

          return RefreshIndicator(
            onRefresh: () async {
              // IMPORTANT: call the function (with parentheses)
              await context.read<NewsData>().fetchData;
            },
            // child must be a scrollable widget
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: storiesList.length,
              itemBuilder: (context, index) {
                final item = storiesList[index] as Map<String, dynamic>;
                return Newscard(map: item);
              },
            ),
          );
        },
      ),
    );
  }
}

class Newscard extends StatelessWidget {
  const Newscard({super.key, required this.map});
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (map['image'] != null && map['image'].toString().isNotEmpty)
                Image.network(
                  map['image'],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(height: 150, child: Center(child: Icon(Icons.broken_image))),
                ),
              const SizedBox(height: 10),
              Text(
                map['heading'] ?? 'No heading',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                map['stories']?.toString() ?? '',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
