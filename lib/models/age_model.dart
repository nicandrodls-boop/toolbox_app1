class AgeModel {
  final int? age;
  final int? count;
  final String? name;

  AgeModel({
    this.age,
    this.count,
    this.name,
  });

  factory AgeModel.fromJson(Map<String, dynamic> json) {
    return AgeModel(
      age: json['age'],
      count: json['count'],
      name: json['name'],
    );
  }
}