import 'dart:typed_data';

class User {
  final int id;
  final String email;
  final String password;
  final String name;
  final String phone;
  final String address;
  final int role;
  final Uint8List image;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.address,
    required this.role,
    required this.image,
  });
}
