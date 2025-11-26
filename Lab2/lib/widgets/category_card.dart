import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  CategoryCard({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Сликата горе
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                category.image,
                height: 100, // фиксна висина
                fit: BoxFit.cover,
              ),
            ),
            // Името
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              child: Text(
                category.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            // Описот со ограничување на редови
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                category.description,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                maxLines: 3,           // ограничување на редови
                overflow: TextOverflow.ellipsis, // ... ако е подолго
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
