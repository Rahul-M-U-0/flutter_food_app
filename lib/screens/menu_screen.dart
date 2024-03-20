import 'package:flutter/material.dart';
import 'package:flutter_aood_app/model/meal.dart';
import 'package:flutter_aood_app/provider/meals_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Consumer<MealsProvider>(
          builder: (context, provider, child) {
            return provider.isLoading
                ? getCategoryLoadingUI()
                : provider.error.isNotEmpty
                    ? getCategoryErrorUI(provider.error)
                    : getCategoryBodyUI(provider.meals);
          },
        ));
  }

  Widget getCategoryLoadingUI() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              color: Colors.black,
              size: 60,
            ),
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryErrorUI(String error) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          error,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget getCategoryBodyUI(Meals meals) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: MediaQuery.of(context).size.height * 0.33,
      ),
      itemCount: meals.meals.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(meals.meals[index]["strMealThumb"]),
              fit: BoxFit.cover,
            ),
          ),
          child: InkWell(
            onTap: () {
              onTapped(meals.meals[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      meals.meals[index]["strMeal"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onTapped(Map<String, dynamic> meal) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            meal["strMeal"],
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          content: SingleChildScrollView(
            child: Text(
              meal["strInstructions"],
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFE7240),
                foregroundColor: Colors.white,
              ),
              child: const Text("Ok"),
            )
          ],
        );
      },
    );
  }
}
