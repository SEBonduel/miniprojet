import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../classes/fruit.dart';
import '../cart_model.dart';
import 'package:provider/provider.dart';

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
        title: const Text("Panier "),
         
      ),
      body:Column(children: [ Expanded(child: Consumer<CartModel>(builder: (context, cart, child) {
      return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(cart.items[index].name),
          subtitle: Text("${cart.items[index].price}€"),
          trailing: IconButton(
            onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        '${cart.items[index].name} a bien été supprimé du panier !')));
                Provider.of<CartModel>(context, listen: false)
                    .remove(cart.items[index]);
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },      );
    },),)],),  
    ); 
  } 
}

         
