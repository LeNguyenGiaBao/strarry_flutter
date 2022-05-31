import 'package:flutter/material.dart';
import 'dart:typed_data';

class Product {
  final String title, description;
  final Uint8List image;
  final int price, size, id;
  final Color color;
  
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.color,
  });
}
