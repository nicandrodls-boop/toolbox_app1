import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/university_model.dart';

class UniversityService {
  Future<List<UniversityModel>> getUniversities(String country) async {
    final url = Uri.parse(
      "https://adamix.net/proxy.php?country=$country",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
          .map(
            (e) => UniversityModel.fromJson(e),
      )
          .toList();
    } else {
      throw Exception("Error al consultar la API");
    }
  }
}