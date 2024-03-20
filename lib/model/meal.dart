// To parse this JSON data, do
//
//     final meals = mealsFromJson(jsonString);

import 'dart:convert';

Meals mealsFromJson(String str) => Meals.fromJson(json.decode(str));

String mealsToJson(Meals data) => json.encode(data.toJson());

class Meals {
  final List<Map<String, dynamic>> meals;

  Meals({
    required this.meals,
  });

  factory Meals.fromJson(Map<String, dynamic> json) => Meals(
        meals: List<Map<String, dynamic>>.from(json["meals"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}
