import 'package:booky/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Product_providers.dart' show ProductProvider;

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late double _price;

  @override
  void initState() {
    super.initState();
    _title = widget.product.title;
    _description = widget.product.description;
    _price = widget.product.price;
  }

  void _updateProduct() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    _formKey.currentState!.save();

    final updatedProduct = Product(
      id: widget.product.id,
      title: _title,
      description: _description,
      price: _price,
    );

    await Provider.of<ProductProvider>(context, listen: false)
        .updateProduct(updatedProduct);

    Navigator.pop(context); // Back to Product Detail or Home
  }

  void _deleteProduct() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Product'),
        content: Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(ctx, false),
          ),
          ElevatedButton(
            child: Text('Delete'),
            onPressed: () => Navigator.pop(ctx, true),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await Provider.of<ProductProvider>(context, listen: false)
          .deleteProduct(widget.product.id);
      Navigator.pop(context); // Back to Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Product Title'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Enter a valid number';
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Save Changes'),
              ),
              SizedBox(height: 10),
              TextButton.icon(
                onPressed: _deleteProduct,
                icon: Icon(Icons.delete, color: Colors.red),
                label: Text('Delete Product', style: TextStyle(color: Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
