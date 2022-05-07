import 'package:get/get.dart';

class Controller extends GetxController{
  var money = 0.obs;
  increment() => money++;
  setMoney(money){
    this.money.value=money;
  }
}