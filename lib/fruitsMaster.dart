import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../classes/fruit.dart';
import './fruit_preview.dart';
import './screens/cartScreen.dart';
import './screens/fruitDetailsScreen.dart';
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
  double _counter = 0;
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
    Fruit? getRandomFruit() {
      widget.list.removeWhere((element) =>
          widget.fruits.where((el) => el.name == element).isNotEmpty);

      return null;
    }

    calculateCartTotalPrice() {
      double totalPrice = 0;
      for (var element in cart) {
        totalPrice += element.price;
      }

      setState(() {
        _counter = totalPrice;
      });
    }

    deleteFromCart(Fruit fruit) {
      cart.removeWhere((element) => element.name == fruit.name);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${fruit.name}(s) bien supprimés du panier !')));
      calculateCartTotalPrice();
    }

    addToCart(Fruit fruit) {
      setState(() {
        _counter += fruit.price;
        cart.add(fruit);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${fruit.name} a bien été ajouté au panier !')));
    }

    openDetails(Fruit fruit) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FruitDetailsScreen(
                  fruit: fruit,
                  deleteFromCart: deleteFromCart,
                  addToCart: addToCart)));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Total: ${_counter.toString()}€',
            textAlign: TextAlign.center,
          ),
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
                      addToCart: addToCart,
                      openDetails: openDetails);
                }),
            CartScreen(cart: cart)
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Fruit? fruit = getRandomFruit();

                if (fruit != null) {
                  setState(() {
                    widget.fruits.insert(0, fruit);
                  });
                }
              },
              tooltip: 'Add Fruit',
              child: const Icon(Icons.add),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _counter = 0;
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
              onPressed: (){
                           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen(cart: [],)),
            );
          },
              tooltip: 'View Cart',
              child: const Icon(Icons.shopping_cart),)
          ],
        ),
    );  
  }
}
