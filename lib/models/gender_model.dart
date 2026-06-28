class GenderModel {
  final String? gender;
  final double? probability;
  final int? count;

  GenderModel({
    this.gender,
    this.probability,
    this.count,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(
      gender: json['gender'],
      probability: json['probability']?.toDouble(),
      count: json['count'],
    );
  }
}