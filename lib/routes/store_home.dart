// ignore_for_file: file_names

import 'package:appointment_app_mobile/routes/cart_page.dart';
import 'package:flutter/material.dart';
import '../components/app_drawer.dart';
import '../components/product_card.dart';

import '../components/app_bar_widget.dart';
import '../components/category_widget.dart';

// ignore: must_be_immutable
class StoreHomeScreen extends StatelessWidget {
  const StoreHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const AppBarWidget(),
        actions: [
          Center(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, 'cart');
                  },
                  icon: const Icon(Icons.shopping_cart),
                )
              ],
            ),
          ),
        ],
      ),
      body: const AllProducts(),
    );
  }
}

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AllProductsState createState() => _AllProductsState();
}

const color = Color.fromARGB(255, 247, 232, 223);

class _AllProductsState extends State<AllProducts> {
  void addToCart() {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ignore: sized_box_for_whitespace
        Container(
          margin: const EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              Image(
                width: 150,
                height: MediaQuery.of(context).size.height * 0.40,
                image: const AssetImage('images/logo.png'),
              ),
              const Text(
                '''
              𝒫𝑒𝓉𝓈 𝒶𝓇𝑒 𝓃𝑜𝓉 𝑜𝓊𝓇 𝓌𝒽𝑜𝓁𝑒 
              𝓁𝒾𝒻𝑒,𝒷𝓊𝓉 𝓉𝒽𝑒𝓎 𝓂𝒶𝓀𝑒 𝑜𝓊𝓇 
              𝓁𝒾𝓋𝑒𝓈 𝓌𝒽𝑜𝓁𝑒.
                  ''',
                style: TextStyle(fontSize: 16.0),
              )
            ],
          ),
        ),
        CategoryWidget(leading: 'New Arival', trailing: 'view more'),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductCard(
                    addToCart: () => addToCart,
                    url: 'images/German1.png',
                    name: 'labordor',
                    price: 99.99,
                  ),
                  ProductCard(
                    addToCart: () => addToCart,
                    url: 'images/labrador.jpg',
                    name: 'doberman',
                    price: 100.0,
                  ),
                  ProductCard(
                    url: 'images/labrador.jpg',
                    name: 'German Shepherd',
                    price: 200.0,
                    addToCart: () => addToCart,
                  ),
                  ProductCard(
                    addToCart: () => addToCart,
                    url: 'images/German1.png',
                    name: 'Rottweiler',
                    price: 235.6,
                  ),
                  ProductCard(
                    addToCart: () => addToCart,
                    url: 'images/labrador.jpg',
                    name: 'Dalmatian',
                    price: 99.99,
                  ),
                ])),
        CategoryWidget(
          leading: 'liked by most',
          trailing: 'view more',
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductCard(
                    addToCart: () => addToCart,
                    url: 'images/labrador.jpg',
                    name: 'labordor',
                    price: 99.99,
                  ),
                  ProductCard(
                    addToCart: () => addToCart,
                    url: 'images/doberman1.jpeg',
                    name: 'doberman',
                    price: 100.0,
                  ),
                  ProductCard(
                    url: 'images/German.png',
                    name: 'German Shepherd',
                    price: 200.0,
                    addToCart: () => addToCart,
                  ),
                  ProductCard(
                    addToCart: () => addToCart,
                    url: 'images/labrador.jpg',
                    name: 'Rottweiler',
                    price: 235.6,
                  ),
                  ProductCard(
                    addToCart: () => addToCart,
                    url: 'images/German1.png',
                    name: 'Dalmatian',
                    price: 99.99,
                  ),
                ])),

        ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const Cart();
                },
              ));
            },
            child: const Text('Got to cart'))
      ],
    );
  }
}
