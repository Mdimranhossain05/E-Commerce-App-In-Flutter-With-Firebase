import 'package:e_commerce_project/splach_scree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); /*These two lines to initialize with firebase*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375,812),
        builder: ()=>MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "E-Commerce",
          theme: ThemeData(primarySwatch: Colors.blue),
          home: SplachScreen(),
    ));
  }
}
