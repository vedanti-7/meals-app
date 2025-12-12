import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:state_notifier/state_notifier.dart';

class FavouriteMealsNotifier extends StateNotifier <List<Meal>>{
  FavouriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal){
    final mealIsFavourite=state.contains(meal);

    if(mealIsFavourite){
      state = state.where((m)=>m.id!=meal.id).toList();
      return false;
    }
    else{
      state=[...state, meal ]; //(...)this means to put all the existing meals and the new meal to the new list
      return true;
    }

  }
}

final favouriteMealsProvider= StateNotifierProvider<FavouriteMealsNotifier,List<Meal>>((ref) {   //if more complex data is there which changes then use 'StateNotifierProvider', it works with 'StateNotifier' class
  return FavouriteMealsNotifier();  //instance of favouritemealsnotifier class returned,   'StateNotifierProvider<FavouriteMealsNotifier,List<Meal>>'these 2 are generic type defination to make sure on what type of value is returned by 'FavouriteMealsNotifier()' object, which will be a list of meals, 'List<Meal>'
});  