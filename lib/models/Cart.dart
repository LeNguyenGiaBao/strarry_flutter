import 'Product.dart';

class Cart {
  final Product product;
  final int numOfItem;

  Cart({required this.product, required this.numOfItem});
}


// List<Product> products = [];
// // List<Cart> demoCarts = [];
// Future loadList() async {
//   await Future.delayed(const Duration(milliseconds: 400));

//   products = [];
//   var url = Uri.parse(backend + 'products/');
//   var response = await http.get(url);
//   var json = jsonDecode(response.body);

//   var productsListJson = json['products'];
//   for (var p in productsListJson) {
//     int id = p[0];
//     String name = p[1];
//     String descriptiton = p[2];
//     int price = p[3];
//     int quantity = p[3];
//     Uint8List image = Base64Codec().decode(p[5]);
//     Product product = new Product(
//         id: id,
//         title: name,
//         price: 12,
//         size: quantity,
//         description: descriptiton,
//         image: image,
//         color: Colors.white);

//     products.add(product);
//   }
// }

// // printToConsole(products);
// // print(products[0]);
// List<Cart> demoCarts = [
//   Cart(product: products[0], numOfItem: 2),
//   Cart(product: products[1], numOfItem: 1),
//   // Cart(product: products[3], numOfItem: 1),
// ];
