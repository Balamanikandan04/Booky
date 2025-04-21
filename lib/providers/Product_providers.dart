import 'package:booky/models/Products.dart';
import 'package:flutter/material.dart';
import '../services/database.dart';

class ProductProvider with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _products = (await _databaseService.fetchProducts())!;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _databaseService.addProduct(product);
    await fetchProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _databaseService.updateProduct(product);
    await fetchProducts();
  }

  Future<void> deleteProduct(String id) async {
    await _databaseService.deleteProduct(id);
    await fetchProducts();
  }

  Product? getById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
