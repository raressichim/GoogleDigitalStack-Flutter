import 'dart:convert';

import 'package:http/http.dart';
import '../models/photo.dart';

class PhotoApi {
  PhotoApi({required String accessKey, required Client client})
      : _accessKey = accessKey,
        _client = client;

  final String _accessKey;
  final Client _client;

  Future<List<Photo>> loadItems(int page, {String query = '', String genre = ''}) async {
    final Uri uri = Uri.parse('https://api.unsplash.com/search/photos?');
    final Response response = await _client.get(
      uri.replace(
        queryParameters: <String, String>{
          'page': '$page',
          if (query.isNotEmpty) 'query_term': query,
          if (genre.isNotEmpty) 'genre': genre,
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> results = data['results'] as List<dynamic>;
      return results
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return <Photo>[];
  }
}

// Future<void> main() async {
//   final client = Client();
//   final api = PhotoApi(
//       accessKey: 'LiCIcjMwix0KXu4u9L1B2A69x80tLD6z8QOsojdePzs', client: client);
//   final items = await api.loadItems(1, 'dog');
//   items.forEach(print);
// }
