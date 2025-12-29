import 'package:ecommerce/features/on_boarding/presentation/ui/login_page/login_page.dart';
import 'package:ecommerce/features/on_boarding/presentation/ui/signup_page/signup_page.dart';
import 'package:ecommerce/features/on_boarding/presentation/ui/splash_page/splash_page.dart';
import 'package:ecommerce/ui/detail_page.dart';
import 'package:ecommerce/ui/home_page.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {


  static const String homePage = "/";
  static const String detailPage = "detail_page";
  static const String loginPage = "loginPage";
  static const String signUpPage = "signUpPage";
  static const String splashPage = "SplashPage";


 static Map<String , WidgetBuilder> routes =
  {
    homePage : (_) => HomePage(),
    detailPage : (_) => DetailPage(),
    loginPage : (_) => LoginPage(),
    signUpPage : (_) => SignupPage(),
    splashPage : (_) => SplashPage()
  };


}