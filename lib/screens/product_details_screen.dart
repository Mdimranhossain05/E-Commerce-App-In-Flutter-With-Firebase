import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_project/const/constants.dart';
import 'package:e_commerce_project/screens/widgets/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailsPage extends StatefulWidget {
  final product;
  const ProductDetailsPage({Key? key,required this.product}) : super(key: key);


  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}


class _ProductDetailsPageState extends State<ProductDetailsPage> {
  var _dotPosition = 0;

  FirebaseAuth auth = FirebaseAuth.instance;




  Future addToCart()async{
    var currentUser = auth.currentUser;
    CollectionReference reference = FirebaseFirestore.instance.collection("users-cart-items");

    return reference.doc(currentUser?.email).collection("items").doc().set(
      {
        "product-name": widget.product["product-name"],
        "product-price": widget.product["product-price"],
        "product-images": widget.product["product-image"],
      }
    ).then((value) => Fluttertoast.showToast(msg: "${widget.product["product-name"]} successfully added to cart"));
  }

  Future addToFavourite()async{
    var currentUser = auth.currentUser;
    CollectionReference reference = FirebaseFirestore.instance.collection("users-favourite-items");
    return reference.doc(currentUser?.email).collection("items").doc().set(
        {
          "product-name": widget.product["product-name"],
          "product-price": widget.product["product-price"],
          "product-images": widget.product["product-image"],
        }
    ).then((value) => Fluttertoast.showToast(msg: "${widget.product["product-name"]} successfully added to favourite"));
  }
  Future removeFromFavourite(AsyncSnapshot snapshot)async{
    var currentUser = auth.currentUser;
    DocumentSnapshot docSnapshot = snapshot.data.docs[0]; //there is only on item when you are on on product page. so index is zero
    return FirebaseFirestore.instance.collection("users-favourite-items").doc(currentUser!.email).collection("items").doc(docSnapshot.id).delete()
    .then((value) => Fluttertoast.showToast(msg: "${widget.product["product-name"]} Successfully removed from favourite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundColor: AppColors.deep_orange,child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){Navigator.pop(context);},),),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").where("product-name", isEqualTo: widget.product["product-name"]).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot ){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(backgroundColor: AppColors.deep_orange,child: IconButton(icon: snapshot.data.docs.length ==0? Icon(Icons.favorite_outline_rounded,color: Colors.white):Icon(Icons.favorite,color: Colors.white) ,onPressed: (){
                  snapshot.data.docs.length ==0? addToFavourite():removeFromFavourite(snapshot);
                  //restart from stream builder
                },),),
              );

              // return Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: CircleAvatar(backgroundColor: AppColors.deep_orange,child: IconButton(icon: snapshot.data.docs.length ==0? Icon(Icons.favorite_outline_rounded,color: Colors.white):Icon(Icons.favorite,color: Colors.white) ,onPressed: (){
              //     snapshot.data.docs.length ==0? removeFromFavourite(snapshot):addToFavourite();
              //     //restart from stream builder
              //   },),),
              // );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(aspectRatio: 1.5,
                child: CarouselSlider(
                    items: widget.product["product-image"].map<Widget>((item) => Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(item),fit: BoxFit.fitWidth)),)).toList(),//here using .toMap to take the images from thi link what is as string and toList using to get them as a alist
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        //enlargeStrategy: CenterPageEnlargeStrategy.height, to make all view at same position
                        onPageChanged: (index,carasoulePageChangedReason){
                          setState(() {
                            _dotPosition = index;
                          });
                        }
                    )),
              ),
              SizedBox(height: 5.h,),
              Center(
                child: DotsIndicator(
                  dotsCount: widget.product["product-image"].length==0? 1:widget.product["product-image"].length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.deep_orange,
                    color: AppColors.deep_orange.withOpacity(0.5),
                    spacing: EdgeInsets.all(2.0),
                    //activeSize: Size(10.h,10.w), It can use to control size of the active dot

                  ),
                ),
              ),
              SizedBox(height: 25.h,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Text("${widget.product["product-name"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
              ),
              SizedBox(height: 15.h,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Text("BDT: ${widget.product["product-price"].toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
              ),
              SizedBox(height: 15.h,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Text("Description: ${widget.product["product-description"]}",style: TextStyle(fontSize: 18.sp),),
              ),
              SizedBox(height: 70.h,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: CustomButtton("Add To Cart", (){addToCart();}),
              ),
              SizedBox(height: 15,)
            ],
          ),
        ),
      )
    );
  }
}
