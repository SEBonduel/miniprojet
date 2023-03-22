import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miniprojet/screens/cartScreen.dart';
import 'package:provider/provider.dart';
import '../classes/fruit.dart';
import './fruitsMaster.dart';
import 'package:http/http.dart' as http;
import './cart_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        Provider(create: (context) => CartScreen),
      ],
      child: MyApp(),
    ),
  );
}


Future<List<Fruit>> loadFruits() async {
  final response =
      await http.get(Uri.parse("https://fruits.shrp.dev/items/fruits"));
  final data = await jsonDecode(response.body);
  final List<Fruit> fruits = [];
  for (var element in data["data"]) {
    Fruit fruit = Fruit(
        element["name"],
        Color(int.parse(
            'FF${element["color"].toString().replaceFirst(("#"), "")}',
            radix: 16)),
        element["price"],
        element["id"],
        element["stock"],
        element["origin"],
        element["season"],
        element["image"]);

    fruits.add(fruit);
  }
  return fruits;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: FutureBuilder(
        builder: (BuildContext ctx, AsyncSnapshot<List<Fruit>> list) {
          if (list.hasData) {
            return FruitsMaster(
                title: 'Flutter Demo Home Page',
                fruits: list.requireData,
                list: list.requireData);
          } else {
            return const Text("Please, wait...");
          }
        },
        future: loadFruits(),
      ),
    );
  }
}
