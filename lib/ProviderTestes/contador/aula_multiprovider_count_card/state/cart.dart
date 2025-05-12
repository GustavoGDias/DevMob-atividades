import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  final List<String> _cart = ['banana', 'maça', 'uva'];

  int get count => _cart.length;

  List<String> get cart => _cart;

  void addItem(String item) {
    _cart.add(item);
    notifyListeners();
  }
}