import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 1;

  int get counter => _counter;

  void add() {
    _counter++;
    notifyListeners();
  }

  void sub() {
    _counter--;
    notifyListeners();
  }

  void init() {
    _counter = 1;
    notifyListeners();
  }
}