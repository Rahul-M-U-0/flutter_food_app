import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aood_app/model/category.dart';
import 'package:flutter_aood_app/model/meal.dart';
import 'package:flutter_aood_app/provider/category_provider.dart';
import 'package:flutter_aood_app/provider/meals_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Today’s Meals",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Consumer<MealsProvider>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? getMealsLoadingUI()
                      : provider.error.isNotEmpty
                          ? getMealsErrorUI(provider.error)
                          : getMealsBodyUI(provider.meals);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Popular Categories",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Consumer<CategoryProvide>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? getCategoryLoading()
                      : provider.error.isNotEmpty
                          ? getCategoryErrorUI(provider.error)
                          : getCategoryBodyUI(provider.category);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getMealsLoadingUI() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.53,
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

  Widget getMealsErrorUI(String error) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.53,
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

  Widget getMealsBodyUI(Meals meals) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.53,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.53,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        ),
        itemCount: meals.meals.length,
        itemBuilder: (context, index, realIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(meals.meals[index]["strMealThumb"]),
                  fit: BoxFit.cover,
                ),
              ),
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
                          fontSize: 22,
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
      ),
    );
  }

  Widget getCategoryLoading() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
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
      height: MediaQuery.of(context).size.height * 0.2,
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

  Widget getCategoryBodyUI(Category category) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xffFE7240),
                        image: DecorationImage(
                          image: NetworkImage(
                              category.categories[index].strCategoryThumb),
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    category.categories[index].strCategory,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
