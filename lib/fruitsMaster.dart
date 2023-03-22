import 'dart:convert';
import 'dart:io';
import 'dart:js_util';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../classes/fruit.dart';
import './fruit_preview.dart';
import './screens/cartScreen.dart';
import './screens/fruitDetailsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'cart_model.dart';

class FruitsMaster extends StatefulWidget {
  const FruitsMaster(
      {super.key,
      required this.title,
      required this.fruits,
      required this.list});
  final String title;
  final List<Fruit> fruits;
  final List<dynamic> list;

  @override
  State<FruitsMaster> createState() => _FruitsMasterState();
}

int next(int min, int max) => min + math.Random().nextInt(max - min);

List<BottomNavigationBarItem> getBottomNavigationBarItems() {
  return const [
    BottomNavigationBarItem(icon: const Icon(Icons.home), label: "Accueil"),
    BottomNavigationBarItem(
        icon: const Icon(Icons.shopping_cart), label: "Panier"),
  ];
}

PageController pageController = PageController(initialPage: 0, keepPage: true);

class _FruitsMasterState extends State<FruitsMaster> {
  List<Fruit> cart = [];

  int navIndex = 0;

  void Navigate(index) {
    setState(() {
      navIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    openDetails(Fruit fruit) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FruitDetailsScreen(
                  fruit: fruit,
                  deleteFromCart:
                      Provider.of<CartModel>(context, listen: false).remove,
                  addToCart:
                      Provider.of<CartModel>(context, listen: false).add)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Consumer<CartModel>(builder: (context, cart, child) {
          return Text(
            "Panier (${cart.items.length})",
            style: const TextStyle(color: Colors.white),
          );
        }),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          Navigate(index);
        },
        children: <Widget>[
          ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.fruits.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return FruitPreview(
                    fruit: widget.fruits[index],
                    addToCart:
                        Provider.of<CartModel>(context, listen: false).add,
                    openDetails: openDetails);
              }),
          CartScreen(cart: cart)
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                cart.clear();
              });
            },
            tooltip: 'Empty Cart',
            child: const Icon(Icons.delete),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CartScreen(
                          cart: [],
                        )),
              );
            },
            tooltip: 'View Cart',
            child: const Icon(Icons.shopping_cart),
          )
        ],
      ),
    );
  }
}
