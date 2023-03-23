import 'package:flutter/material.dart';

class QuantityBadge extends StatelessWidget{
  const QuantityBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          "0",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}