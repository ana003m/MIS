import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen({required this.favoriteMeals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: favoriteMeals.isEmpty
          ? Center(child: Text('No favorite meals yet!'))
          : GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemCount: favoriteMeals.length,
        itemBuilder: (context, index) {
          final meal = favoriteMeals[index];
          return MealCard(
            meal: meal,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MealDetailScreen(mealId: meal.id)));
            },
          );
        },
      ),
    );
  }
}
