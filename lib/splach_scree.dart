import 'dart:async';

import 'package:e_commerce_project/const/constants.dart';
import 'package:e_commerce_project/screens/bottom_nav_controller.dart';
import 'package:e_commerce_project/screens/bottom_nav_pages/home_screen.dart';
import 'package:e_commerce_project/screens/login_screen.dart';
import 'package:e_commerce_project/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplachScreen extends StatefulWidget {

  const SplachScreen({Key? key}) : super(key: key);

  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {

  RouteManage()async{
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>BottomNavBar())));
    } else {
      Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>RegistrationScreen())));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    RouteManage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("E-Commerce",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 44.sp),),
            SizedBox(height: 10.h,),
            CircularProgressIndicator(color: Colors.white,),


          ],
        ),
      ),
    );
  }

}
