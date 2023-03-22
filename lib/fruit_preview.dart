import 'package:flutter/material.dart';
import 'package:miniprojet/cart_model.dart';
import './classes/fruit.dart';
import './screens/fruitDetailsScreen.dart';
import 'package:provider/provider.dart';

class FruitPreview extends StatelessWidget {
  const FruitPreview(
      {super.key,
      required this.fruit,
      required this.addToCart,
      required this.openDetails});

  final Fruit fruit;
  final Function addToCart;
  final Function openDetails;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${fruit.name} ${fruit.price}€"),
      tileColor: fruit.color,
      onTap: () => {openDetails(fruit)},
      trailing: Material(
          child: IconButton(
        onPressed: () => {Provider.of<CartModel>(context, listen: false).add(fruit)},
        icon: const Icon(Icons.shopping_cart_checkout),
        color: Colors.black,
      )),
      leading: Image.asset("../assets/img/${fruit.name.replaceAll('è', 'e')}.png",
          fit: BoxFit.contain,
          height: 40, errorBuilder: (context, error, stackTrace) {
        return Image.asset("../assets/img/default.jpg", width: 0);
      }),
    );
  }
}
