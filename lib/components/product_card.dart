import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  ProductCard(
      {Key? key,
      required this.url,
      required this.name,
      required this.price,
      required this.addToCart})
      : super(key: key);
  String url;
  String name;
  double price;
  VoidCallback addToCart;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(7.0),
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width * 0.30,
          decoration: BoxDecoration(
              color: Colors.blueAccent.shade400,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1, color: Colors.blue)),
          child: Image.network(url),
        ),
        Text(name),
        Text(
          price.toString(),
        ),
        IconButton(
            onPressed: () {
              addToCart();
            },
            icon: const Icon(Icons.add_shopping_cart_sharp))
      ],
    );
  }
}
