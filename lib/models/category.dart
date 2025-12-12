import 'package:flutter/material.dart';

class Category {
  const Category({      //used to initialize the below objects(final string id, title,..) and set these properties
    required this.id,
    required this.title,
    this.color= Colors.orange //default color set(initialized).
  });

  final String id;
  final String title;
  final Color color;
}