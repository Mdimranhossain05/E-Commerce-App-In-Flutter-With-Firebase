import 'package:e_commerce_project/const/constants.dart';
import 'package:e_commerce_project/screens/login_screen.dart';
import 'package:e_commerce_project/screens/user_data_screen.dart';
import 'package:e_commerce_project/screens/widgets/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passController = TextEditingController();
    bool _isObsecure = true;


    FirebaseAuth auth = FirebaseAuth.instance;



    SignUp() async{
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passController.text,
        );
        var authCredential = userCredential.user;
        print(authCredential!.uid);
        if(authCredential.uid.isNotEmpty){

          Navigator.push(context, CupertinoPageRoute(builder: (_)=>UserDataScreen()));
        }
        else{
          Fluttertoast.showToast(msg: "Something is wrong");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(msg: "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(msg: 'The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }

    



    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.light,color: Colors.transparent,)),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  )
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h,),
                        Text(
                          "Welcome Buddy!",
                          style: TextStyle(
                              fontSize: 22.sp, color: AppColors.deep_orange),
                        ),
                        Text(
                          "Glad to see you buddy.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFFBBBBBB),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(
                                color: AppColors.deep_orange,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(Icons.email_outlined,color: Colors.white,size: 20.w,),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    hintText: "thed9954@gmail.com",
                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xFF414041),
                                    ),
                                    labelText: 'EMAIL',
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.deep_orange,)
                                )
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(
                                color: AppColors.deep_orange,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(Icons.lock_outline,color: Colors.white,size: 20.w,),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextFormField(

                                  controller: _passController,
                                  obscureText: _isObsecure,
                                  decoration: InputDecoration(
                                      hintText: "password must be 6 character",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xFF414041),
                                      ),
                                      labelText: 'PASSWORD',
                                      labelStyle: TextStyle(
                                        fontSize: 15.sp,
                                        color: AppColors.deep_orange,),
                                    suffixIcon: _isObsecure==true?
                                        IconButton(onPressed: (){
                                          setState(() {
                                            _isObsecure = false;
                                          });
                                        },icon: Icon(
                                          Icons.remove_red_eye,
                                          size: 20.w,
                                        ))
                                        : IconButton(onPressed: (){
                                          setState(() {
                                            _isObsecure = true;
                                          });
                                        },
                                            icon: Icon(
                                              Icons.visibility_off,
                                              size: 20.w,
                                            ))
                                  ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomButtton("Continue", (){SignUp();}),
                        SizedBox(
                          height: 20.h,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFBBBBBB),
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                " Sign In",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deep_orange,
                                ),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
