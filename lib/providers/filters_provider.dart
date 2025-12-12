import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:state_notifier/state_notifier.dart';

enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,

}

class FiltersNotifier extends StateNotifier <Map<Filter,bool>> {
  FiltersNotifier() : super({  //constructor used to pass an initial state to the class, here the initail state is a function(super({func..})), which is a map of filters and where all filters are set initially to false.
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
  }); 

  void setFilters(Map<Filter,bool> chosenFilters) {  //a new map of filter settings used to override existing state.
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    //state[filter] = isActive; // not allowed because we cannot mutate the state, state cannot be changed, see down..  
    state = {   //so we are creating a new list
      ...state, //copies the existing key and values of map to new map
      filter: isActive, //new key value pair overriding the old key value pair 
    };
  }
}

 final filtersProvider  = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  
  return meals.where((meal) {
      if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){     //_selectedFilters[Filter.glutenFree]!, the exclamation mark in the end means that it tells that, the value will never be null.
        return false;
      }
      if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){     //_selectedFilters[Filter.glutenFree]!, the exclamation mark in the end means that it tells that, the value will never be null.
        return false;
      }
      if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){     //_selectedFilters[Filter.glutenFree]!, the exclamation mark in the end means that it tells that, the value will never be null.
        return false;
      }
      if(activeFilters[Filter.vegan]! && !meal.isVegan){     //_selectedFilters[Filter.glutenFree]!, the exclamation mark in the end means that it tells that, the value will never be null.
        return false;
      }
      return true;
    }).toList();
});