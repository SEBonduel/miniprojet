import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../classes/fruit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.cart});

  final List<Fruit> cart;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
      ),
      body: ListView.builder(
      itemCount: widget.cart.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.cart[index].name),
          subtitle: Text("${widget.cart[index].price}€"),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        '${widget.cart[index].name} a bien été supprimé du panier !')));
                widget.cart.removeAt(index);
              });
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    ));
  }
}

         
