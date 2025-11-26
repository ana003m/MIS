import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  MealCard({required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // текстот центриран
          children: [
            SizedBox(height: 10), // ✔️ простор над сликата

            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                meal.image,
                height: 140,            // ✔️ поголема слика
                width: double.infinity,
                fit: BoxFit.cover,      // ✔️ изгледа убава
              ),
            ),

            SizedBox(height: 10), // ✔️ простор под сликата

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                meal.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // нема overflow
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
