class UniversityModel {
  final String name;
  final List<dynamic> domains;
  final List<dynamic> webPages;

  UniversityModel({
    required this.name,
    required this.domains,
    required this.webPages,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      name: json['name'],
      domains: json['domains'] ?? [],
      webPages: json['web_pages'] ?? [],
    );
  }
}