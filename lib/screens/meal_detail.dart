import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';

class MealDetailScreen extends ConsumerWidget{
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {   //'WidgetRef ref' used to listen to the providers.
    final favouriteMeals = ref.watch(favouriteMealsProvider);

    final isFavourite = favouriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {  //'wasAdded' used to check through provider of 'favouriteMelasProvider' whether meal was added as a favourite or not.
              final wasAdded=ref.read(favouriteMealsProvider.notifier).toggleMealFavoriteStatus(meal); //'favouriteMealsProvider.notifier'  gives access to the state notifier class mentioned in the favouriteMeals.dart file which has the toggleFavouriteMeal method logic in it.
              ScaffoldMessenger.of(context).clearSnackBars(); //clearing all existing snackbars 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded ? 'Meal added as a favourite' : 'Meal removed '),
                ),
              );
            },
            icon: AnimatedSwitcher(   
              duration: const Duration(milliseconds: 300),         //AnimatedSwitcher allows animating transition from one widget to another
              transitionBuilder: (child,animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8, end: 1).animate(animation), 
                  child: child,
                );
              },
              child: Icon(isFavourite ? Icons.star : Icons.star_border, //this star liking icon upon each recipe will have a rotating animation when clicked, so after clicking it would go to animation switcher
              key: ValueKey(isFavourite),
              ),
            ) ,  
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            const SizedBox(height: 30),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}




// Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(50),
//               child: Image.asset('url', height: 40),
//             ),
//             const Text('title'),
//           ],
//         ),
//       ),
//     );
//   }
// }