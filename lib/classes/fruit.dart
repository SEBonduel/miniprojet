import 'package:flutter/material.dart';

class Fruit {
  late String name;
  late Color color;
  late double price;
  late int id;
  late int stock;
  late int origin;
  late String season;
  late String image;

  Fruit(String _name, Color _color, double _price, int _id, int _stock,
      int _origin, String _season, String _image) {
    name = _name;
    color = _color;
    price = _price;
  }

  factory Fruit.fromJson(dynamic json) {
    return Fruit(
      json['name'],
      Color(json['color']),
      json['price'],
      json['id'],
      json['stock'],
      json['origin'],
      json['season'],
      json['image'],
    );
  }

  get originLocation => null;
}
