import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val){
                  setState(() {
                    inputText = val;
                    print(inputText);
                  });
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Product Name",
                    hintStyle: TextStyle(fontSize: 15.sp),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),//to reduce default radius
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),//to reduce default radius
                        borderSide: BorderSide(
                            color: Colors.grey
                        )
                    )
                ),
              ),
              SizedBox(height: 10,),
              Expanded(child: Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("products").where("product-name",isGreaterThanOrEqualTo: inputText).snapshots(),//To get exact search sult we can use isEqualTo
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){ //Using data type for the query search of product
                    if(snapshot.hasError){
                      return Center(child: Text("Something went wrong"),);
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: Text("Loading..."),);
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document){
                        Map<String,dynamic> data = document.data() as Map<String,dynamic>;
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            title: data["product-name"]!=null? Text(data["product-name"]):Text("Empty"),
                            leading: data["product-image"][0]!=null? Image.network(data["product-image"][0]):Text("Empty Image"),
                          ),
                        );
                      }).toList()

                    );

                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
