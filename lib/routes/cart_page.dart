import 'package:appointment_app_mobile/routes/store_home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ((() {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const StoreHomeScreen();
              },
            ));
          })),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: const Text('total no. of items in cart:'),
        ),
      ),
    );
  }
}



/**
 * 
 *  void showcart() {
    var cart = DartCart();

    //add produto to cart productId end price
    cart.addToCart(productId: 111, unitPrice: 200);
    cart.addToCart(
        productId: 112,
        unitPrice: 400,
        quantity: 7,
        productDetailsObject: 'New produto',
        productName: 'Book',
        uniqueCheck: true);

    //incrementItemToCart
    cart.incrementItemToCart(0);
    cart.incrementItemToCart(0);
    cart.incrementItemToCart(0);

    //decrementItemFromCart
    cart.decrementItemFromCart(1);
    cart.decrementItemFromCart(1);

    //Total Price
    var total = cart.getTotalAmount();

    // Count
    var qtd = cart.getCartItemCount();

    log('Total to Cart $qtd');
    log('Total $total');
  }
 */