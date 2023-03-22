import 'dart:collection';
import 'package:flutter/material.dart';
import './classes/fruit.dart';

class CartModel extends ChangeNotifier {
  final List<Fruit> _items = [];

  UnmodifiableListView<Fruit> get items => UnmodifiableListView(_items);

  double get totalPrice => _items.fold(0, (total, current) => total + current.price);

  void add(Fruit fruit) {
    _items.add(fruit);
    notifyListeners();
  }

  void remove(Fruit fruit) {
    _items.remove(fruit);
    notifyListeners();
  }
}