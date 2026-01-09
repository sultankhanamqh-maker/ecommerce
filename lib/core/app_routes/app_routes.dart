import 'package:ecommerce/core/services/api_services.dart';
import 'package:ecommerce/features/dashboard/presentation/ui/nav_pages/cart_nav_page/cart_nav_page.dart';
import 'package:ecommerce/features/on_boarding/presentation/ui/login_page/login_page.dart';
import 'package:ecommerce/features/on_boarding/presentation/ui/signup_page/signup_page.dart';
import 'package:ecommerce/features/on_boarding/presentation/ui/splash_page/splash_page.dart';
import 'package:ecommerce/features/detail/detail_product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/category_page/category_detail_page.dart';
import '../../features/dashboard/presentation/bloc/product/product_bloc.dart';
import '../../features/dashboard/presentation/bloc/product/product_event.dart';
import '../../features/dashboard/presentation/ui/dashboard_page/dashboard_page.dart';
import '../../features/orders/presentation/ui/order/order_page.dart';
import '../../features/product/product_detail_page.dart';

class AppRoutes {
  static const String detailPage = "detail_page";
  static const String loginPage = "loginPage";
  static const String signUpPage = "signUpPage";
  static const String splashPage = "SplashPage";
  static const String dashboardPage = "dashboardPage";
  static const String cartNavPage = "cartNavPage";
  static const String orderPage = "orderPage";
  static const String productDetailPage = "productDetailPage";
  static const String categoryDetailPage = "categoryDetailPage";



 static Map<String , WidgetBuilder> routes =
  {
    detailPage : (_) => DetailPage(),
    loginPage : (_) => LoginPage(),
    signUpPage : (_) => SignupPage(),
    splashPage : (_) => SplashPage(),
    dashboardPage : (_) => DashboardPage(),
    cartNavPage : (_) => CartNavPage(),
    orderPage : (_) => OrderPage(),
    productDetailPage : (_) => ProductDetailPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    int categoryId = 0;
    switch (settings.name) {

      case categoryDetailPage:

         categoryId = int.parse(settings.arguments.toString());

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => ProductBloc(apiServices : ApiServices.apiServices)
              ..add(ProductSearchEvent(categoryId: categoryId)),
            child: CategoryDetailPage(categoryId: categoryId),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }



}