import 'package:e_commerce_project/const/constants.dart';
import 'package:e_commerce_project/screens/bottom_nav_pages/cart.dart';
import 'package:e_commerce_project/screens/bottom_nav_pages/favourite.dart';
import 'package:e_commerce_project/screens/bottom_nav_pages/home_screen.dart';
import 'package:e_commerce_project/screens/bottom_nav_pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  final pages = [HomePage(),FavouritePage(),CartPage(),Profilepage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("E-commerce",style: TextStyle(color: Colors.black),),centerTitle: true,backgroundColor: Colors.transparent, elevation: 0,automaticallyImplyLeading: false,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),title: Text("Fovirite")),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart),title: Text("Cart")),
          BottomNavigationBarItem(icon: Icon(Icons.person),title: Text("Profile")),
        ],
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
          body: pages[currentIndex],
    );
  }
}
