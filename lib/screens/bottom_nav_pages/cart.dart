import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/const/constants.dart';
import 'package:e_commerce_project/screens/widgets/fetchCollection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FetchCollection("users-cart-items", Colors.blue),
        )
      );
  }
}
