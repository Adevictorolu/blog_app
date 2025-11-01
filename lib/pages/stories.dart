import 'package:flutter/material.dart';
import 'package:project_2/model/newsdata.dart';
import 'package:provider/provider.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return NewsData();
      }, builder: (context, child) {
        return Scaffold(
            body: Consumer<NewsData>(builder: (context, value, child) {
            return FutureBuilder(
              future: value.fetchData,
              builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Try several common list property names on the provider
              dynamic list;
              try {
                list = value.fetchData;
              } catch (_) {
                list = [];
              }

              if (list == null || (list is List && list.isEmpty)) {
                return const Center(child: Text('No data'));
              }

              // Helper to pick fields from Map or model object (tries common keys/getters)
              String getField(dynamic item, List<String> keys) {
                for (var k in keys) {
                if (item == null) continue;
                if (item is Map && item.containsKey(k) && item[k] != null) return item[k].toString();
                try {
                  var v;
                  switch (k) {
                  case 'title':
                    v = item.title;
                    break;
                  case 'name':
                    v = item.name;
                    break;
                  case 'headline':
                    v = item.headline;
                    break;
                  case 'description':
                    v = item.description;
                    break;
                  case 'summary':
                    v = item.summary;
                    break;
                  case 'body':
                    v = item.body;
                    break;
                  case 'imageUrl':
                    v = item.imageUrl;
                    break;
                  case 'urlToImage':
                    v = item.urlToImage;
                    break;
                  case 'thumbnail':
                    v = item.thumbnail;
                    break;
                  case 'image':
                    v = item.image;
                    break;
                  default:
                    v = null;
                  }
                  if (v != null) return v.toString();
                } catch (_) {}
                }
                return '';
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (context, index) {
                final item = list[index];
                final title = getField(item, ['title', 'name', 'headline']);
                final subtitle = getField(item, ['description', 'summary', 'body']);
                final imageUrl = getField(item, ['urlToImage', 'imageUrl', 'thumbnail', 'image']);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(title.isNotEmpty ? title : 'Detail'),
                      content: SingleChildScrollView(child: Text(subtitle.isNotEmpty ? subtitle : 'No description')),
                      actions: [
                      TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))
                      ],
                    ),
                    );
                  },
                  child: Row(
                    children: [
                    if (imageUrl.isNotEmpty)
                      ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.network(
                        imageUrl,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => Container(
                        width: 110,
                        height: 110,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 40),
                        ),
                      ),
                      )
                    else
                      Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: const Icon(Icons.article, size: 40, color: Colors.grey),
                      ),
                    Expanded(
                      child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          title.isNotEmpty ? title : 'Untitled',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subtitle.isNotEmpty ? subtitle : 'No description available',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                        ),
                        ],
                      ),
                      ),
                    ),
                    ],
                  ),
                  ),
                );
                },
              );
              },
            );
            },)
        );
      },
    );
  }
}