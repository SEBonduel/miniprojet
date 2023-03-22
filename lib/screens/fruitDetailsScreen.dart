import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../classes/fruit.dart';

class FruitDetailsScreen extends StatefulWidget {
  const FruitDetailsScreen(
      {super.key,
      required this.fruit,
      required this.deleteFromCart,
      required this.addToCart});

  final Fruit fruit;
  final Function deleteFromCart;
  final Function addToCart;
  @override
  _FruitDetailsScreenState createState() => _FruitDetailsScreenState();
}

class _FruitDetailsScreenState extends State<FruitDetailsScreen> {
  Fruit? fruit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fruit.name),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("../../assets/img/${widget.fruit.name}.png",
              fit: BoxFit.contain,
              height: 100, errorBuilder: (context, error, stackTrace) {
            return Image.asset("../../assets/img/default.png", width: 0);
          }),
          const Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Text(widget.fruit.name, style: const TextStyle(fontSize: 25)),
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Text("${widget.fruit.price}€", style: const TextStyle(fontSize: 20)),
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          TextButton(
              onPressed: () => {widget.deleteFromCart(widget.fruit)},
              child: const Text("Supprimer du panier"))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.addToCart(widget.fruit);
        },
        tooltip: 'Add Fruit',
        child: const Icon(Icons.add),
      ),
    );
  }
}
