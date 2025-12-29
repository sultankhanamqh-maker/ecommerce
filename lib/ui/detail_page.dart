import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    var list =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 280,
                  child: Image.network(list["image"], fit: BoxFit.cover),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  left: 16,
                  child: Row(
                    children: [
                      _iconButton(
                        icon: Icons.arrow_back_ios_new_outlined,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                      _iconButton(icon: Icons.share, onPressed: () {}),
                      SizedBox(width: 11),
                      _iconButton(
                        icon: Icons.favorite_border_rounded,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wireless HeadPhone \n \$300",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Color(0xfffe660e),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 20),
                            Text("4.8", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Text(" {320 Reviews}"),
                      Spacer(),
                      Text("Seller : Tariq aslam"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Color",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      _container(bgColor: Colors.black),
                      _container(bgColor: Colors.green),
                      _container(bgColor: Colors.red),
                      _container(bgColor: Colors.blue),
                      _container(bgColor: Colors.amber),
                    ],
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _ElevatedBtn(onPressed: () {}, name: "Description"),
                        _ElevatedBtn(onPressed: () {}, name: "Specification"),
                        _ElevatedBtn(onPressed: () {}, name: "Reviews"),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffc1bdbd),
                    ),
                    "i am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullahi am habibullah",
                  ),
                  Stack(
                    children: [

                      Container(
                        width: double.infinity,
                        height: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.black
                        ),

                        child: Positioned(
                          bottom: 8,
                          left: 16,
                          right: 16,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: BoxBorder.all(
                                      color: Colors.white
                                    )
                                  ),
                                  child: Row(children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white
                                      ),
                                      onPressed: () {
                                        if(count>1){
                                          count--;
                                          setState(() {

                                          });
                                        }
                                      },
                                      child: Text("-", style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))),
                                  Text("$count", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white
                                      ),
                                      onPressed: () {
                                        count++;
                                        setState(() {

                                        });

                                      },
                                      child: Text("+", style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))),

                                ],),),
                                Spacer(),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffff650e),
                                        foregroundColor: Colors.white
                                    ),
                                    onPressed: () {},
                                    child: Text("Add To Cart"))
                              ],

                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ElevatedBtn({required VoidCallback onPressed, required String name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: onPressed, child: Text(name)),
    );
  }

  Widget _container({required Color bgColor}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.8),
        ),
        child: Center(child: Icon(icon, color: Colors.black)),
      ),
    );
  }
}
