import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/const/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget FetchCollection(String collectionName,color){
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection(collectionName).doc(FirebaseAuth.instance.currentUser!.email).collection("items").snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){ //Using <QuerySnapshot> to get some extra property from it like length
      if(snapshot.hasError){
        Fluttertoast.showToast(msg: "Something went wrong");
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(color: AppColors.deep_orange,),);
      }
      return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
            return ListTile(
              leading: Image.network(docSnapshot["product-images"][0]),
              title: Text(docSnapshot["product-name"]+"\t Price: \$"+docSnapshot["product-price"].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
              trailing: GestureDetector(
                onTap: (){
                  FirebaseFirestore.instance.collection(collectionName).doc(FirebaseAuth.instance.currentUser!.email).collection("items").doc(docSnapshot.id).delete()
                      .then((value) => Fluttertoast.showToast(msg: "${docSnapshot["product-name"]} is successfully removed from favourites"));
                },
                child: CircleAvatar(child: Icon(Icons.remove_circle,color: Colors.white,),backgroundColor: color,),
              ),
            );
          });
    },
  );
}