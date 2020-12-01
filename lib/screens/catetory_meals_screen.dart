import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static String routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, idx) {
            final item = categoryMeals[idx];
            print(item.imageUrl);
            return MealItem(
                id: item.id,
                title: item.title,
                imageUrl: item.imageUrl,
                duration: item.duration,
                complexity: item.complexity,
                affordability: item.affordability
                );
          },
          itemCount: categoryMeals.length,
        ));
  }
}
