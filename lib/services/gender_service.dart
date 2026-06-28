import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/gender_model.dart';

class GenderService {

  Future<GenderModel> getGender(String name) async {

    final url = Uri.parse(
      'https://api.genderize.io/?name=$name',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return GenderModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Error al consultar la API');
    }
  }

}