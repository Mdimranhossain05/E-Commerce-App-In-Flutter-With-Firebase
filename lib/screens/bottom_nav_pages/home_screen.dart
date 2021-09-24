import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_project/const/constants.dart';
import 'package:e_commerce_project/screens/bottom_nav_pages/search_screen.dart';
import 'package:e_commerce_project/screens/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> carouselImages = [];
  var _firestoreInstence = FirebaseFirestore.instance;
  var _dotPosition = 0;
  List _products = [];

  fetchCarouselImages() async{

    QuerySnapshot querySnapshot = await _firestoreInstence.collection("carousel-slider").get();

    setState(() {
      for (int i=0;i<querySnapshot.docs.length;i++){
        carouselImages.add(
          querySnapshot.docs[i]["img"],

        );
        print(querySnapshot.docs[i]["img"]);
      }
    });
    return querySnapshot.docs;
  }

  fetchProduct() async{
    QuerySnapshot querySnapshot = await _firestoreInstence.collection("products").get();

    setState(() {
      for (int i=0;i<querySnapshot.docs.length;i++){
        _products.add(
          {
            "product-name":querySnapshot.docs[i]["product-name"],
            "product-description":querySnapshot.docs[i]["product-description"],
            "product-price":querySnapshot.docs[i]["product-price"],
            "product-image":querySnapshot.docs[i]["product-image"],
          }
        );
      }
    });
    return querySnapshot.docs;
  }





  @override
  void initState() {
    // TODO: implement initState
    fetchCarouselImages();
    fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Expanded(child: SizedBox(
                      height: 60.h,
                      child: TextFormField(
                        readOnly: true,
                        onTap: (){
                          Navigator.push(context,CupertinoPageRoute(builder: (context)=>SearchScreen()));
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "To search product tap here",
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
                      ))),
                  /*Container(
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(color: AppColors.deep_orange),
                    child: Center(
                      child: Icon(Icons.search,color: Colors.white,),
                    ),
                  )*/
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            AspectRatio(aspectRatio: 3.5,
              child: CarouselSlider(
                  items: carouselImages.map((item) => Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(item),fit: BoxFit.fitWidth)),)).toList(),//here using .toMap to take the images from thi link what is as string and toList using to get them as a alist
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,

                    //enlargeStrategy: CenterPageEnlargeStrategy.height, to make all view at same position
                    onPageChanged: (index,carasoulePageChangedReason){
                      setState(() {
                        _dotPosition = index;
                      });
                    }
                  )),
            ),
            SizedBox(height: 10.h,),
            DotsIndicator(
                dotsCount: carouselImages.length==0? 1:carouselImages.length,
              position: _dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.deep_orange,
                color: AppColors.deep_orange.withOpacity(0.5),
                spacing: EdgeInsets.all(2.0),
                //activeSize: Size(10.h,10.w), It can use to control size of the active dot

              ),
            ),
            SizedBox(height: 15.h,),
            Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: _products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1),
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetailsPage(product: _products[index],)));
                        },
                        child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(aspectRatio: 1.5, child: Image.network(_products[index]["product-image"][0])),
                              Text(_products[index]["product-name"]),
                              Text("Price: "+_products[index]["product-price"].toString()),
                            ],
                          ),
                        ),
                      );
                    }
                )
            )

          ],
        ),
      ),
    );
  }
}
