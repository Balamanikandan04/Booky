import 'package:booky/providers/Product_providers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Screens/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await  Firebase.initializeApp();
    runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: MaterialApp(
        title: 'Booky App',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: HomeScreen(),
      ),
    );
  }
}