import 'package:ecommerce/core/app_routes/app_routes.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  List<Map<String, dynamic>> listCos = [
    {
      "name": "shoes",
      "image":
          "https://images.pexels.com/photos/19090/pexels-photo.jpg?_gl=1*puumzt*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM2MDckajU5JGwwJGgw",
    },
    {
      "name": "Beauty",
      "image":
          "https://images.pexels.com/photos/2113855/pexels-photo-2113855.jpeg?_gl=1*bl88vu*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM2OTEkajM5JGwwJGgw",
    },
    {
      "name": "Women's Fashion",
      "image":
          "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?_gl=1*107jry6*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM3ODEkajYwJGwwJGgw",
    },
    {
      "name": "Jewelry",
      "image":
          "https://images.pexels.com/photos/248077/pexels-photo-248077.jpeg?_gl=1*1kmjjnf*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM4OTIkajYwJGwwJGgw",
    },
    {
      "name": "shoes",
      "image":
          "https://images.pexels.com/photos/19090/pexels-photo.jpg?_gl=1*puumzt*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM2MDckajU5JGwwJGgw",
    },
    {
      "name": "Beauty",
      "image":
          "https://images.pexels.com/photos/2113855/pexels-photo-2113855.jpeg?_gl=1*bl88vu*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM2OTEkajM5JGwwJGgw",
    },
    {
      "name": "Women's Fashion",
      "image":
          "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?_gl=1*107jry6*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM3ODEkajYwJGwwJGgw",
    },
    {
      "name": "Jewelry",
      "image":
          "https://images.pexels.com/photos/248077/pexels-photo-248077.jpeg?_gl=1*1kmjjnf*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM4OTIkajYwJGwwJGgw",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfff6f6f6),
                      ),
                      child: Icon(Icons.menu),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfff6f6f6),
                      ),
                      child: Icon(Icons.notifications_none),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xfff6f6f6),
                    prefix: Icon(Icons.search),
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/images/shoes.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCos.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              listCos[index]["image"],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(listCos[index]["name"]),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 5,
                child: GridView.builder(
                  itemCount: listCos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4/6
                  ),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.detailPage , arguments: listCos[index]);
                      },

                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: AppConstants.appColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: Icon(Icons.favorite_border_rounded,color: Colors.white,size: 15,),
                                ),
                              ),
                              Expanded(child: Image.network(listCos[index]["image"])),
                              Text("Wire less Headphones"),
                              Row(
                                children: [
                                  Expanded(child: Text("\$300")),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
