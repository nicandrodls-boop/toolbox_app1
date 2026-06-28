import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/age_model.dart';

class AgeService {
  Future<AgeModel> getAge(String name) async {
    final url = Uri.parse(
      'https://api.agify.io/?name=$name',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AgeModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Error al consultar la API');
    }
  }
}