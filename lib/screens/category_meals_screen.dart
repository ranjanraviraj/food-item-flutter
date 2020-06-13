import 'package:flutter/material.dart';

import '../model/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const CategoryMealROute = '/category_meal';

  final List<Meal> availableMeal;

  CategoryMealScreen(this.availableMeal);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> filteredMeal;
  var isLoadData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isLoadData) {
      final routesArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routesArgs['id'];
      categoryTitle = routesArgs['title'];
      filteredMeal = widget.availableMeal.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      isLoadData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      filteredMeal.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: filteredMeal[index].id,
            title: filteredMeal[index].title,
            affordability: filteredMeal[index].affordability,
            complexity: filteredMeal[index].complexity,
            duration: filteredMeal[index].duration,
            imageUrl: filteredMeal[index].imageUrl,
          );
        },
        itemCount: filteredMeal.length,
      ),
    );
  }
}
