import 'package:flutter/material.dart';

import '../model/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoritesMeal;

  FavoritesScreen(this._favoritesMeal);

  @override
  Widget build(BuildContext context) {
    if (_favoritesMeal.isEmpty) {
      return Center(
        child: Text('You have no favourite yet - start adding some'),
      );
    } else{
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _favoritesMeal[index].id,
            title: _favoritesMeal[index].title,
            affordability: _favoritesMeal[index].affordability,
            complexity: _favoritesMeal[index].complexity,
            duration: _favoritesMeal[index].duration,
            imageUrl: _favoritesMeal[index].imageUrl,
          );
        },
        itemCount: _favoritesMeal.length,
      );
    }
  }
}
