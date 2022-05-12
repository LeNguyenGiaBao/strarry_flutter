import 'package:get/get.dart';

class Controller extends GetxController {
  var money = 0.obs;
  String? email;
  String? fullname;
  String? address;
  String? phone;
  int idcategory = 0;
  var products = [];
  increment() => money++;
  setMoney(money) {
    this.money.value = money;
  }

  setEmail(email) {
    this.email = email;
  }

  setFullName(fullname) {
    this.fullname = fullname;
  }

  setAddress(address) {
    this.address = address;
  }

  setPhone(phone) {
    this.phone = phone;
  }

  setIdCategory(idcategory) {
    this.idcategory = idcategory;
  }

  setProducts(products) {
    this.products = products;
  }
}
