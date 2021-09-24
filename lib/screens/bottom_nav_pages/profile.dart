import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/const/constants.dart';
import 'package:e_commerce_project/screens/registration_screen.dart';
import 'package:e_commerce_project/screens/widgets/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {

  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _ageController;

  setDataToTextField(data){
    return Column(
      children: [

        TextFormField(
            controller: _nameController = TextEditingController(text: data["name"]),
            decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.deep_orange,)
            )
        ),
        SizedBox(height: 10,),
        TextFormField(
            controller: _phoneController = TextEditingController(text: data["phone"]),
            decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.deep_orange,)
            )
        ),
        SizedBox(height: 10,),
        TextFormField(
            controller: _ageController = TextEditingController(text: data["age"]),
            decoration: InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.deep_orange,)
            )
        ),
        SizedBox(height: 30,),
        CustomButtton("Log Out", (){logOut();}),
        SizedBox(height:10,),
        CustomButtton("Update", (){updateData();}),


      ],
    );
  }

  updateData(){
    CollectionReference _reference = FirebaseFirestore.instance.collection("users-form-data");
    return _reference.doc(FirebaseAuth.instance.currentUser?.email).update({
      "name" : _nameController?.text,
      "phone" : _phoneController?.text,
      "age" : _ageController?.text

    }).then((value) => Fluttertoast.showToast(msg: "Updated Successfully."));

  }
  logOut()async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>RegistrationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser?.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              var data = snapshot.data;
              return data != null? setDataToTextField(data):Container(child: Center(child: CircularProgressIndicator(color: AppColors.deep_orange,),),);
            },
          ),
        ),
      ),
    );
  }
}
