// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';

import 'package:appointment_app_mobile/models.dart/Products.dart';
import 'package:appointment_app_mobile/models.dart/cart.dart';
import 'package:appointment_app_mobile/utils/services.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app_mobile/utils/constants.dart' as constant;

class CartPage extends StatefulWidget {
  //final List<CartItem> cartItems;

  const CartPage();

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<List<List<Product>>>? getProductsDetails() async {
    List<List<Product>> productList = [];

    List<Cart> cartItems = await Services.getCurrentCartItems();
    for (Cart cartItem in cartItems) {
      List<Product> product = await Services.getProductById(cartItem.itemId!);
      productList.add(product);
    }
    log(productList.toString());
    return productList;
  }

  @override
  void initState() {
    super.initState();
    getProductsDetails();
  }

  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      //quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        // quantity--;
      }
    });
  }

  String path = constant.path;
  void deleteItem(String itemid) {
    setState(() {
      quantity++;
      Services.deleteItem(itemid);
      quantity--;
    });
  }

  void confirmOrder(String itemid) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My AppBar'),
      ),
      body: FutureBuilder(
        future: getProductsDetails(),
        builder: (context, AsyncSnapshot<List<List<Product>>> snapshot) {
          if (snapshot.hasError) log(snapshot.error.toString());
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    List<Product>? list = snapshot.data!.elementAt(index);
                    return Card(
                      elevation: 5.0,
                      child: SizedBox(
                        height: 120.0,
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                "$path/backend/image_upload_php_mysql/uploads/${list.first.itemImage!}",
                                width: 90,
                                height: 90,
                                fit: BoxFit.scaleDown,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${list.first.itemName!} ",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${list.first.itemBrand} ",
                                        style: const TextStyle(fontSize: 10.0),
                                      ),
                                      Text(
                                        "${list.first.itemPrice} ",
                                        style: const TextStyle(fontSize: 8.0),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 75.0,
                                          ),
                                          IconButton(
                                            onPressed: decrementQuantity,
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text("$quantity"),
                                          IconButton(
                                            onPressed: incrementQuantity,
                                            icon: const Icon(Icons.add),
                                          ),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () {
                                              deleteItem(list.first.itemId!);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Order Confirmation'),
                content: const Text(
                    'Are you sure you want to order all of  the following items?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      // Perform order operation
                      Services.addOrder();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        label: const Text('Proceed to Checkout'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
