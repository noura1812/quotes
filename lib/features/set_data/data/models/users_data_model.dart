class UsersDataModel {
  int color;
  String name;
  List<String> categories;
  UsersDataModel({
    required this.color,
    required this.name,
    required this.categories,
  });
  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'name': name,
      'categories': categories,
    };
  }

  static UsersDataModel fromJson(Map<String, dynamic> json) {
    return UsersDataModel(
      color: json['color'],
      name: json['name'],
      categories: List<String>.from(json['categories']),
    );
  }
}
