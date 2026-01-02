import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/features/dashboard/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 1;
  int selectedIndex = 0;
  bool isSelected = false;
  List<Color> mColor = [
    Colors.red,
    Colors.green,
    Colors.black,
    Colors.yellow,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    var mProduct = ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 45,
                  child: Container(
                    color: Colors.grey.shade100,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.share),
                              ),
                              SizedBox(width: 11),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.favorite_outline),
                              ),
                            ],
                          ),
                        ),
                        Center(child: Image.network(mProduct.image!)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 55,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(31),
                        topRight: Radius.circular(31),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mProduct.name!,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$ ${mProduct.price!}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: AppConstants.appColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text(
                                        "4.8",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 11),
                              Text(
                                "(320 Reviews)",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Color",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          StatefulBuilder(
                            builder: (context, ss) {
                              return Row(
                                children: List.generate(mColor.length, (index) {
                                  final isSelected = selectedIndex == index;
                                  return InkWell(
                                    onTap: () {
                                      selectedIndex = index;
                                      ss(() {});
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 2),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: isSelected
                                            ? Border.all(
                                                color: Color(0xff6A6868FF),
                                                width: 2,
                                              )
                                            : null,
                                      ),
                                      child: isSelected
                                          ? Center(
                                              child: Container(
                                                width: 45,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: mColor[index],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: mColor[index],
                                              ),
                                            ),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                          width: 1,
                          color: Colors.white
                        )
                      ),
                      child: StatefulBuilder(
                        builder: (context,ss) {

                          return Row(
                            children: [
                              TextButton(onPressed: (){
                                if(count> 1){
                                  count--;
                                  ss((){});
                                }


                              }, child: Text("-",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),)),
                              Text("$count",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),),
                              TextButton(onPressed: (){
                                count++;
                                ss((){});
                              }, child: Text("+",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),))
                            ],
                          );
                        }
                      ),
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(31),
                          color: AppConstants.appColor,
                        ),child: Center(child: Text("Add to Cart",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),)),
                      ),
                    ),

                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
