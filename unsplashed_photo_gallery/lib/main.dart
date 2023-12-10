import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

const String accessKey = 'LiCIcjMwix0KXu4u9L1B2A69x80tLD6z8QOsojdePzs';

void main() {
  runApp(const PhotoGallery());
}

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Photo> items = <Photo>[];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    final Client client = Client();

    final Response response = await client.get(
        Uri.parse('https://api.unsplash.com/photos'),
        headers: <String, String>{'Authorization': 'Client-ID $accessKey'});

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

      for (final dynamic item in data) {
        items.add(Photo(item as Map<String, dynamic>));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollable List'),
      ),
      body: Stack(
        children: <Widget>[
          GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index == items.length - 1 && !isLoading) {
                loadItems();
              }
              return Center(
                child: GridTile(
                  child: Image.network(
                    items[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

class Photo {
  Photo(Map<String, dynamic> json)
      : description = json['description'] as String? ?? '',
        imageUrl =
            ((json['urls'] as Map<String, dynamic>?)?['regular'] as String?) ??
                '';

  final String description;
  final String imageUrl;

  @override
  String toString() {
    return 'Photo{description: $description, imageUrl: $imageUrl}';
  }
}
