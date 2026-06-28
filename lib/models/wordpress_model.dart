class WordpressModel {
  final String title;
  final String excerpt;
  final String link;

  WordpressModel({
    required this.title,
    required this.excerpt,
    required this.link,
  });

  factory WordpressModel.fromJson(Map<String, dynamic> json) {
    return WordpressModel(
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      link: json['link'],
    );
  }
}