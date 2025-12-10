import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'favorites_screen.dart';
import 'meal_detail_screen.dart';

class CategoryMealsScreen extends StatefulWidget {
  final String categoryName;
  CategoryMealsScreen({required this.categoryName});

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  final ApiService apiService = ApiService();
  List<Meal> meals = [];
  List<Meal> filteredMeals = [];
  List<Meal> favoriteMeals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  void fetchMeals() async {
    meals = await apiService.getMealsByCategory(widget.categoryName);
    await loadFavorites();
    setState(() {
      filteredMeals = meals;
      isLoading = false;
    });
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = prefs.getStringList('favoriteMeals') ?? [];
    favoriteMeals = meals.where((m) => savedIds.contains(m.id)).toList();
  }

  void toggleFavorite(Meal meal) async {
    setState(() {
      if (favoriteMeals.contains(meal)) {
        favoriteMeals.remove(meal);
      } else {
        favoriteMeals.add(meal);
      }
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'favoriteMeals',
      favoriteMeals.map((m) => m.id).toList(),
    );
  }
  void openFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = prefs.getStringList('favoriteMeals') ?? [];

    final favoriteMealsList = meals.where((m) => savedIds.contains(m.id)).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FavoritesScreen(favoriteMeals: favoriteMealsList),
      ),
    );
  }

  void searchMeals(String query) async {
    filteredMeals = await apiService.searchMeals(query);
    setState(() {});
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: openFavorites,
          ),
        ],
        backgroundColor: Colors.teal,),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Meal',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(),
              ),
              onChanged: searchMeals,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredMeals.length,
              itemBuilder: (context, index) {
                final meal = filteredMeals[index];
                final isFavorite = favoriteMeals.contains(meal);
                return Stack(
                  children: [
                    MealCard(
                      meal: meal,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MealDetailScreen(mealId: meal.id),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color: Colors.yellow[700],
                        ),
                        onPressed: () => toggleFavorite(meal),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}