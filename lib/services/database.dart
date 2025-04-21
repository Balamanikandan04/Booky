import 'package:booky/models/Products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference _productRef =
  FirebaseFirestore.instance.collection('product');

  Future<List<Product>> fetchProducts() async {
    final snapshot = await _productRef.get();
    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> addProduct(Product product) async {
    await _productRef.add(product.toMap());
  }

  Future<void> updateProduct(Product product) async {
    await _productRef.doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await _productRef.doc(id).delete();
  }

  Future<Product?> getProductById(String id) async {
    final doc = await _productRef.doc(id).get();
    if (!doc.exists) return null;
    return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }
}
