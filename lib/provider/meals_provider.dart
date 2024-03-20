import 'package:flutter/material.dart';
import 'package:flutter_aood_app/model/meal.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class MealsProvider extends ChangeNotifier {
  static const apiEndpoint =
      "https://www.themealdb.com/api/json/v1/1/search.php?f=b";

  bool isLoading = true;
  String error = "";
  Meals meals = Meals(meals: []);

  // get
  getMealFromAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        meals = mealsFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
