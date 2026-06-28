import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/wordpress_model.dart';

class WordpressService {
  Future<List<WordpressModel>> getPosts() async {

    final url = Uri.parse(
      'https://kinsta.com/wp-json/wp/v2/posts?_embed&per_page=3',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {

      final List data = jsonDecode(response.body);

      return data
          .map(
            (e) => WordpressModel.fromJson(e),
      )
          .toList();

    } else {
      throw Exception("Error");
    }
  }
}