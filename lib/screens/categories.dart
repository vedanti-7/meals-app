//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatefulWidget{
  const CategoriesScreen({
    super.key,
    required this.availableMeals
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin{    //SingleTickerProviderStateMixin class provides various animation to this categories class via its state class.
  late AnimationController _animationController;   //late keyword will tell flutter that this var will have a value as soon as it is created but not yet when the class is created.

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,  //'this' allows to fire our animation once per frame.
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,   //lb & ub means that flutter will animate between which 2 values
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();   //animation disposed as soon as this widget is removed not causing any memory overflows.
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals= widget.availableMeals.where((meal) => meal.categories.contains(category.id),).toList();  //checks for the category matching with the category id passed in as parameter.

    Navigator.of(context).push(      //same as Navigator.push(context,route)
      MaterialPageRoute(
        builder: (ctx)=>MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );   
  }

  @override
  Widget build(BuildContext context){
    return AnimatedBuilder(
      animation: _animationController,
      child : GridView(
        padding: const EdgeInsets.all(9),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20, 
          mainAxisSpacing: 20
        ),
        children:[
          for(final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context,category);
              },
          ),
        ],
    ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController, 
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),  
    );
  }
}