import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';
// import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/constants.dart';

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



// List<Product> products = [];
//   Future loadList() async {
//     await Future.delayed(const Duration(milliseconds: 400));

//     products = [];
//     var url = Uri.parse(backend + 'products/');
//     var response = await http.get(url);
//     var json = jsonDecode(response.body);

//     var productsListJson = json['products'];
//     for (var p in productsListJson) {
//       int id = p[0];
//       String name = p[1];
//       String descriptiton = p[2];
//       int price = p[3];
//       int quantity = p[3];
//       Uint8List image = Base64Codec().decode(p[5]);
//       Product product = new Product(
//           id: id,
//           title: name,
//           price: 12,
//           size: quantity,
//           description: descriptiton,
//           image: image,
//           color: Colors.white);

//       products.add(product);
// class Product {
//   final int id, size;
//   final String title, description;
//   final String image;
//   final Color color;
//   final double rating, price;
//   final bool isFavourite, isPopular;

//   Product({
//     required this.id,
//     required this.image,
//     required this.color,
//     this.size = 12,
//     this.rating = 0.0,
//     this.isFavourite = false,
//     this.isPopular = false,
//     required this.title,
//     required this.price,
//     required this.description,
//   });
// }

// List<Product> products = [
//   Product(
//       id: 1,
//       title: "Office Code",
//       price: 234,
//       size: 12,
//       description: dummyText,
//       image: "assets/images/bag_1.png",
//       color: Color(0xFF3D82AE)),
//   Product(
//       id: 2,
//       title: "Belt Bag",
//       price: 234,
//       size: 8,
//       description: dummyText,
//       image: "assets/images/bag_2.png",
//       color: Color(0xFFD3A984)),
//   Product(
//       id: 3,
//       title: "Hang Top",
//       price: 234,
//       size: 10,
//       description: dummyText,
//       image: "assets/images/bag_3.png",
//       color: Color(0xFF989493)),
//   Product(
//       id: 4,
//       title: "Old Fashion",
//       price: 234,
//       size: 11,
//       description: dummyText,
//       image: "assets/images/bag_4.png",
//       color: Color(0xFFE6B398)),
//   Product(
//       id: 5,
//       title: "Office Code",
//       price: 234,
//       size: 12,
//       description: dummyText,
//       image: "assets/images/bag_5.png",
//       color: Color(0xFFFB7883)),
//   Product(
//     id: 6,
//     title: "Office Code",
//     price: 234,
//     size: 12,
//     description: dummyText,
//     image: "assets/images/bag_6.png",
//     color: Color(0xFFAEAEAE),
//   ),
//   Product(
//     id: 7,
//     title: "Office Code",
//     price: 234,
//     size: 12,
//     description: dummyText,
//     image: "assets/images/bag_6.png",
//     color: Color(0xFFAEAEAE),
//   ),
//   Product(
//     id: 6,
//     title: "Office Code",
//     price: 234,
//     size: 12,
//     description: dummyText,
//     image: "assets/images/bag_6.png",
//     color: Color(0xFFAEAEAE),
//   ),
//   Product(
//     id: 6,
//     title: "Office Code",
//     price: 234,
//     size: 12,
//     description: dummyText,
//     image: "assets/images/bag_6.png",
//     color: Color(0xFFAEAEAE),
//   ),
// ];

// String dummyText =
//     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
