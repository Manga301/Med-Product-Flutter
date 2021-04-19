import 'package:flutter/material.dart';
import 'package:med_products_app/screens/product_screen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductScreen(),
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.black45,
        ),
      ),
    );
