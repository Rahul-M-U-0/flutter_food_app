import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aood_app/provider/category_provider.dart';
import 'package:flutter_aood_app/provider/meals_provider.dart';
import 'package:flutter_aood_app/screens/home_screen.dart';
import 'package:flutter_aood_app/screens/menu_screen.dart';
import 'package:flutter_aood_app/screens/user_profiles_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    //meals
    final mealsProvider = Provider.of<MealsProvider>(context, listen: false);
    mealsProvider.getMealFromAPI();

    //category
    final categoryProvider =
        Provider.of<CategoryProvide>(context, listen: false);
    categoryProvider.getCategoryAPI();
    super.initState();
  }

  //Titles
  static const List<Widget> _titleOptions = <Widget>[
    Text(
      'Home',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
      ),
    ),
    Text(
      'Menu',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
      ),
    ),
    Text(
      'Users',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
      ),
    ),
  ];

  //Trailing Icons
  static const List<Widget> _trailingIcons = <Widget>[
    Icon(
      CupertinoIcons.home,
      size: 28,
    ),
    Icon(
      Icons.fastfood_outlined,
      size: 28,
    ),
    Icon(
      CupertinoIcons.person_fill,
      size: 28,
    ),
  ];

  //Bodies
  static const List<Widget> _bodyList = <Widget>[
    HomeScreen(),
    MenuScreen(),
    UserProfilesScreen(),
  ];

  //
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: _titleOptions[_selectedIndex],
        centerTitle: true,
        actions: [
          _trailingIcons[_selectedIndex],
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: _bodyList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade200,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
              size: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fastfood_outlined,
              size: 28,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_fill,
              size: 28,
            ),
            label: 'Profiles',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xffFE7240),
        onTap: onItemTapped,
      ),
    );
  }
}
