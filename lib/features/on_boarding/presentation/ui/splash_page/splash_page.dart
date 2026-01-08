import 'dart:async';

import 'package:ecommerce/core/app_routes/app_routes.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/app_colors.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.tokenLoginKey) ?? "";
      String nextPage = AppRoutes.loginPage;
      if(token.isNotEmpty){
       nextPage = AppRoutes.dashboardPage;
      }
      Navigator.pushReplacementNamed(context, nextPage);
    });
    return Scaffold(
      backgroundColor: AppColors.mainAppColor,
      body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Icon(Icons.shopping_cart_sharp,color: Colors.white,size: 150,),
        Text("Ecommerce",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)
      ])),
    );
  }
}
