import 'package:booky/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Product_providers.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  double _price = 0;

  void _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    _formKey.currentState!.save();

    final newProduct = Product(
      id: '', // Firestore will assign ID
      title: _title,
      description: _description,
      price: _price,
    );

    await Provider.of<ProductProvider>(context, listen: false)
        .addProduct(newProduct);

    Navigator.pop(context); // Back to Home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Title'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Enter a number';
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
