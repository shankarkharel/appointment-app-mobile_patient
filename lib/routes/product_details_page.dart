import 'package:appointment_app_mobile/utils/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models.dart/Products.dart';
import 'package:appointment_app_mobile/utils/constants.dart' as constant;

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  static const String path = constant.path;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.itemName!),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            const SizedBox(height: 16),
            _buildProductInfo(),
            const SizedBox(height: 16),
            _buildDescription(),
            _buildAddToCartButton(context, product.itemId!),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "$path/backend/image_upload_php_mysql/uploads/${product.itemImage!}"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.itemName!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            product.itemBrand!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Price: ${product.itemPrice!}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            ' ${product.itemDescription}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        product.itemRegister!.split(" ").first.toString(),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, String itemid) {
    return SizedBox(
      width: 320,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () async {
          var pref = await SharedPreferences.getInstance();
          var id = pref.getString("id");

          bool response = await Services.addToCart(userId: id!, itemId: itemid);
          if (response == true) {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item Added to cart'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Couldn\'t add item to cart'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Add to Cart'),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
