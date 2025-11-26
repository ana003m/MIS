import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;
  MealDetailScreen({required this.mealId});

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService apiService = ApiService();
  late Future<MealDetail> mealDetail;

  @override
  void initState() {
    super.initState();
    mealDetail = apiService.getMealDetail(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal Detail'),
        backgroundColor: Colors.teal,),
      body: FutureBuilder<MealDetail>(
        future: mealDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final meal = snapshot.data!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(meal.image),
                SizedBox(height: 8),
                Text(meal.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...meal.ingredients.map((i) => Text(i)).toList(),
                SizedBox(height: 8),
                Text('Instructions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(meal.instructions),
                if (meal.youtubeUrl.isNotEmpty)
                  TextButton(
                    onPressed: () => launchUrl(Uri.parse(meal.youtubeUrl)),
                    child: Text('Watch on YouTube'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
