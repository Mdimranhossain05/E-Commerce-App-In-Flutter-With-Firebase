import 'package:e_commerce_project/const/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CustomButtton(String btntxt,onPressedfun){
  return SizedBox(
    width: 1.sw,
    height: 56.h,
    child: ElevatedButton(
      onPressed: () {
        onPressedfun();
      },
      child: Text(
        btntxt,
        style: TextStyle(
            color: Colors.white, fontSize: 18.sp),
      ),
      style: ElevatedButton.styleFrom(
        primary: AppColors.deep_orange,
        elevation: 3,
      ),
    ),
  );
}