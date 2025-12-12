import 'package:flutter/material.dart';
//import 'package:test_drive/data/dummy_data.dart';
//import 'package:test_drive/screens/categories.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:test_drive/screens/meals.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 69, 95, 91),
  ),
  
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );  
}

class App extends StatelessWidget {
  const App({super.key});  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home:  const TabsScreen()// Todo ...,
    );
  }
}