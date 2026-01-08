import 'package:ecommerce/core/app_routes/app_routes.dart';
import 'package:ecommerce/core/services/api_services.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/category/category_bloc.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/product/product_bloc.dart';
import 'package:ecommerce/features/on_boarding/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/dashboard/presentation/bloc/cart/cart_bloc.dart';
import 'features/dashboard/presentation/bloc/profile/profile_bloc.dart';
import 'features/orders/presentation/bloc/order_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc(apiServices: ApiServices.apiServices)),
        BlocProvider(
          create: (context) => ProductBloc(apiServices: ApiServices.apiServices),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(apiServices: ApiServices.apiServices),
        ),
        BlocProvider(create: (context) => CartBloc(apiServices: ApiServices.apiServices)),
        BlocProvider(create: (context) => ProfileBloc(apiServices: ApiServices.apiServices)),
        BlocProvider(create: (context) => OrderBloc(apiServices: ApiServices.apiServices)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.splashPage,
      routes: AppRoutes.routes,
    );
  }
}
