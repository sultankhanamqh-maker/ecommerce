import 'package:ecommerce/core/app_routes/app_routes.dart';
import 'package:ecommerce/core/services/api_services.dart';
import 'package:ecommerce/features/on_boarding/presentation/bloc/user_bloc.dart';
import 'package:ecommerce/ui/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => UserBloc(apiServices: ApiServices())),
  ], child: MyApp()));
}


class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.splashPage,
      routes: AppRoutes.routes,
    );
  }


}