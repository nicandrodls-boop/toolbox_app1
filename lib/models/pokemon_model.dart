class PokemonModel {
  final String name;
  final String image;
  final int baseExperience;
  final List<String> abilities;
  final String cry;

  PokemonModel({
    required this.name,
    required this.image,
    required this.baseExperience,
    required this.abilities,
    required this.cry,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      image: json['sprites']['front_default'] ?? '',
      baseExperience: json['base_experience'] ?? 0,
      abilities: (json['abilities'] as List)
          .map((e) => e['ability']['name'].toString())
          .toList(),
      cry: json['cries']['latest'] ?? '',
    );
  }
}