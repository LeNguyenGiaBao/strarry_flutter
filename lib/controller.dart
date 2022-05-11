import 'package:get/get.dart';

class Controller extends GetxController {
  var money = 0.obs;
  String? email;
  String? fullname;
  String? address;
  String? phone;
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
}
