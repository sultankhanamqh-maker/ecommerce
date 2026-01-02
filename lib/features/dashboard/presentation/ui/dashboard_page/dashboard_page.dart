import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/features/dashboard/presentation/ui/nav_pages/home_nav_page/home_nav_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    HomeNavPage(),
    HomeNavPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:mPages[selectedIndex] ,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){
              selectedIndex = 0;
              setState(() {

              });
            }, icon: Icon(Icons.menu_open_outlined,color: selectedIndex == 0 ? AppConstants.appColor.withAlpha(80) : Colors.grey)),
            IconButton(onPressed: (){
              selectedIndex = 1;
              setState(() {

              });
            }, icon: Icon(Icons.favorite_outline,color: selectedIndex == 1 ? AppConstants.appColor.withAlpha(80) : Colors.grey)),
            SizedBox(width: 70,),
            IconButton(onPressed: (){
              selectedIndex = 3;
              setState(() {

              });
            }, icon: Icon(Icons.shopping_cart_outlined,color: selectedIndex == 3 ? AppConstants.appColor.withAlpha(80) : Colors.grey)),
            IconButton(onPressed: (){
              selectedIndex = 4;
              setState(() {

              });
            }, icon: Icon(Icons.account_circle_outlined,color: selectedIndex == 4 ? AppConstants.appColor.withAlpha(80) : Colors.grey)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),backgroundColor: AppConstants.appColor,onPressed: (){
        selectedIndex = 2;
        setState(() {

        });
      },child: Icon(color: Colors.white,Icons.home_outlined),),

    );

  }
}