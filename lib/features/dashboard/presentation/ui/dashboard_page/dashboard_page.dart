import 'package:ecommerce/core/constants/app_colors.dart';
import 'package:ecommerce/features/dashboard/presentation/ui/nav_pages/cart_nav_page/cart_nav_page.dart';
import 'package:ecommerce/features/dashboard/presentation/ui/nav_pages/home_nav_page/home_nav_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../nav_pages/accont_nav_page/account_nav_page.dart';

class DashboardPage extends StatefulWidget{
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 2;

  List<Widget> mPages = [
    HomeNavPage(),
    HomeNavPage(),
    HomeNavPage(),
    CartNavPage(),
    AccountNavPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:mPages[selectedIndex] ,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){
              selectedIndex = 0;
              setState(() {

              });
            }, icon: Icon(Icons.menu_open_outlined,color: selectedIndex == 0 ? AppColors.mainAppColor.withAlpha(80) : Colors.grey)),
            IconButton(onPressed: (){
              selectedIndex = 1;
              setState(() {

              });
            }, icon: Icon(Icons.favorite_outline,color: selectedIndex == 1 ? AppColors.mainAppColor.withAlpha(80) : Colors.grey)),
            SizedBox(width: 70,),
            IconButton(onPressed: (){
              selectedIndex = 3;
              setState(() {

              });
            }, icon: Icon(Icons.shopping_cart_outlined,color: selectedIndex == 3 ? AppColors.mainAppColor.withAlpha(80) : Colors.grey)),
            IconButton(onPressed: (){
              selectedIndex = 4;
              setState(() {

              });
            }, icon: Icon(Icons.account_circle_outlined,color: selectedIndex == 4 ? AppColors.mainAppColor.withAlpha(80) : Colors.grey)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),backgroundColor: AppColors.mainAppColor,onPressed: (){
        selectedIndex = 2;
        setState(() {

        });
      },child: Icon(color: Colors.white,Icons.home_outlined),),

    );

  }
}