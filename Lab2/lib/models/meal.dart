class Meal {
  final String id;
  final String name;
  final String image;

  Meal({required this.id, required this.name, required this.image});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      image: json['strMealThumb'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
  };
}

class MealDetail {
  final String id;
  final String name;
  final String image;
  final String instructions;
  final List<String> ingredients;
  final String youtubeUrl;

  MealDetail({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    required this.ingredients,
    required this.youtubeUrl,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String ingredient = json['strIngredient$i'] ?? '';
      String measure = json['strMeasure$i'] ?? '';
      if (ingredient.isNotEmpty) {
        ingredients.add('$ingredient - $measure');
      }
    }
    return MealDetail(
      id: json['idMeal'],
      name: json['strMeal'],
      image: json['strMealThumb'],
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
      youtubeUrl: json['strYoutube'] ?? '',
    );
  }
}
