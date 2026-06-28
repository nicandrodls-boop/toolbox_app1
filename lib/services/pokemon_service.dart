import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pokemon_model.dart';

class PokemonService {
  Future<PokemonModel> getPokemon(String name) async {
    final url = Uri.parse(
      'https://pokeapi.co/api/v2/pokemon/${name.toLowerCase()}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Pokémon no encontrado");
    }
  }
}