// ignore_for_file: file_names, unnecessary_const

import 'dart:convert';
import 'dart:developer';

import 'package:appointment_app_mobile/routes/cart_page.dart';
import 'package:appointment_app_mobile/utils/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/app_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:appointment_app_mobile/utils/constants.dart' as constant;

import '../components/app_bar_widget.dart';
import '../models.dart/Products.dart';
import '../models.dart/cart.dart';
import 'product_details_page.dart';

// ignore: must_be_immutable
class StoreHomeScreen extends StatefulWidget {
  const StoreHomeScreen({Key? key}) : super(key: key);

  @override
  State<StoreHomeScreen> createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  int noOfCartItems = 0;
  Future<List<Cart>> initialFetch() async {
    List<Cart> cartItems = await Services.getCurrentCartItems();
    int noOfCartItem = cartItems.length;
    var pref = await SharedPreferences.getInstance();
    pref.setInt("noOfCartItems", noOfCartItem);
    setState(() {
      noOfCartItems = noOfCartItem;
    });
    return cartItems;
  }

  @override
  void initState() {
    super.initState();
    // initialFetch();
  }

  @override
  Widget build(BuildContext context) {
    initialFetch();

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: MyAppBar(
        itemCountInCart: noOfCartItems,
        onCartPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        },
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

const String path = constant.path;
const color = Color.fromARGB(255, 247, 232, 223);

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TopOFThePage(),
          SizedBox(height: 16),
          const BuildProductList(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class BuildProductList extends StatelessWidget {
  const BuildProductList({
    Key? key,
  }) : super(key: key);
  Future<List<Product>> allProducts() async {
    var url = "$path/backend/image_upload_php_mysql/viewAll.php";
    var response = await http.get(Uri.parse(url));
    var list = json.decode(response.body);

    final productsArray =
        list.map<Product>((json) => Product.fromJson(json)).toList();
    return productsArray;
  }

  void _navigateToProductDetails(Product product, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: allProducts(),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasError) log(snapshot.error.toString());
          return snapshot.hasData
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    List<Product>? list = snapshot.data;
                    final product = list!.elementAt(index);
                    return GestureDetector(
                        onTap: () =>
                            _navigateToProductDetails(product, context),
                        child: Card(
                            elevation: 4,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "$path/backend/image_upload_php_mysql/uploads/${list.elementAt(index).itemImage}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      list.elementAt(index).itemName!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      '\$${list.elementAt(index).itemPrice!}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ])));
                  })
              : const CircularProgressIndicator();
        });
  }
}

class TopOFThePage extends StatelessWidget {
  const TopOFThePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
