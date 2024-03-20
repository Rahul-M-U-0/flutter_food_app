import 'package:flutter/material.dart';
import 'package:flutter_aood_app/model/category.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CategoryProvide extends ChangeNotifier {
  static const apiEndpoint =
      "https://www.themealdb.com/api/json/v1/1/categories.php";
  bool isLoading = true;
  String error = "";
  Category category = Category(categories: []);

  getCategoryAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        category = categoryFromJson(response.body);
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
