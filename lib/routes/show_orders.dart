// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';
import 'package:appointment_app_mobile/routes/store_home.dart';
import 'package:flutter/material.dart';

import '../models.dart/Products.dart';
import '../models.dart/orders.dart';
import '../utils/services.dart';
import '../utils/constants.dart' as constants;

class OrdersPage extends StatefulWidget {
  //final List<CartItem> cartItems;

  const OrdersPage();
  @override
  // ignore: library_private_types_in_public_api
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Future<List<List<Product>>>? getProductsDetails() async {
    List<List<Product>> productList = [];

    List<Order> ordertItems = await Services.getOrderItemsById();
    for (Order ordertItem in ordertItems) {
      List<Product> product = await Services.getProductById(ordertItem.itemId!);
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

  String path = constants.path;
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
        title: const Text('Everything you have Ordered'),
        leading: IconButton(
            onPressed: (() {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const StoreHomeScreen();
                },
              ));
            }),
            icon: const Icon(Icons.arrow_back)),
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
                                        "ID: ${list.first.itemId} ",
                                        style: const TextStyle(fontSize: 10.0),
                                      ),
                                      Text(
                                        "${list.first.itemPrice} ",
                                        style: const TextStyle(fontSize: 8.0),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.confirmation_num))
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
                  child: Text("Nothing To display"),
                );
        },
      ),
    );
  }
}
