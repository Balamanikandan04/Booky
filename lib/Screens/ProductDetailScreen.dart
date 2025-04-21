import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Product_providers.dart';
import 'EditProductScreen.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false)
        .getById(productId);

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Product Details")),
        body: Center(child: Text("Product not found.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title), // ✅ Changed from product.name to product.title
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProductScreen(product: product),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${product.title}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Description: ${product.description}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Price: ₹${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16)),
           
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              label: Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
