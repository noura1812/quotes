import 'dart:convert';

import 'package:quotes/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<UsersDataModel> getCash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString(Constants.cachedUserData);
    return UsersDataModel.fromJson(jsonDecode(json ?? ''));
  }
}
