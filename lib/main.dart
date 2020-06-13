import 'package:flutter/material.dart';

import './model/dummy.dart';
import './model/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_bottom_screen.dart';
import './screens/tabs_top_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'Gluten': false,
    'Lactose': false,
    'Vegetarian': false,
    'Vegan': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;

  List<Meal> _favoritesMeal = [];

  void _toggleFavorite(String mealId) {
    final mealIndex = _favoritesMeal.indexWhere(
      (meal) => meal.id == mealId,
    );
    if (mealIndex >= 0) {
      setState(() {
        _favoritesMeal.removeAt(mealIndex);
      });
    } else {
      setState(() {
        _favoritesMeal.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool isFavorite(String id){
    return _favoritesMeal.any((meal) => meal.id == id);
  }

  void _saveFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['Gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filters['Lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filters['Vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (filters['Vegan'] && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeal',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsBottomScreen(_favoritesMeal),
        CategoryMealScreen.CategoryMealROute: (ctx) =>
            CategoryMealScreen(availableMeals),
        MealDetailScreen.MealDetailROute: (ctx) => MealDetailScreen(isFavorite, _toggleFavorite),
        FiltersScreen.FiltersROute: (ctx) =>
            FiltersScreen(_filters, _saveFilters),
      },
    );
  }
}
