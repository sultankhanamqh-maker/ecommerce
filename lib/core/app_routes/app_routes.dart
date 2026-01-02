
import 'package:ecommerce/features/on_boarding/presentation/ui/login_page/login_page.dart';
import 'package:ecommerce/features/on_boarding/presentation/ui/signup_page/signup_page.dart';
import 'package:ecommerce/features/on_boarding/presentation/ui/splash_page/splash_page.dart';
import 'package:ecommerce/features/detail/detail_page.dart';
import 'package:ecommerce/features/dashboard/presentation/ui/nav_pages/home_nav_page/home_nav_page.dart';
import 'package:flutter/cupertino.dart';

import '../../features/dashboard/presentation/ui/dashboard_page/dashboard_page.dart';

class AppRoutes {

  static const String detailPage = "detail_page";
  static const String loginPage = "loginPage";
  static const String signUpPage = "signUpPage";
  static const String splashPage = "SplashPage";
  static const String dashboardPage = "dashboardPage";


 static Map<String , WidgetBuilder> routes =
  {
    detailPage : (_) => DetailPage(),
    loginPage : (_) => LoginPage(),
    signUpPage : (_) => SignupPage(),
    splashPage : (_) => SplashPage(),
    dashboardPage : (_) => DashboardPage(),
  };


}