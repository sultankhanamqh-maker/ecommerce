import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/core/app_routes/app_routes.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/core/services/api_services.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/category/category_bloc.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/category/category_event.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/category/category_state.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/product/product_bloc.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/product/product_event.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/product/product_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../category_page/category_detail_page.dart';



class HomeNavPage extends StatefulWidget {
  @override
  State<HomeNavPage> createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {

  List<Map<String,dynamic>> listCos = [
    {
    "image" : "https://images.pexels.com/photos/19090/pexels-photo.jpg?_gl=1*puumzt*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM2MDckajU5JGwwJGgw",
    },
    {
      "image" : "https://images.pexels.com/photos/2113855/pexels-photo-2113855.jpeg?_gl=1*bl88vu*_ga*ODk1MDkxNDI5LjE3NTgxOTAwNjc.*_ga_8JE65Q40S6*czE3NjA5MTM0MjMkbzMkZzEkdDE3NjA5MTM2OTEkajM5JGwwJGgw",
    }
      ];

  List<String> mBanners = [
    "https://coreldrawdesign.com/resources/previews/preview-special-offer-discount-sale-banner-template-1601301453.webp",
    "https://mir-s3-cdn-cf.behance.net/project_modules/fs/3ce709113389695.60269c221352f.jpg",
    "https://www.shutterstock.com/image-vector/sale-banner-layout-design-vector-260nw-2444547953.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOQyxO9xrltN1zqk0yk8Lq4CkPUWlyTMgXWw&s",
  ];

  int selectedIndex = 0;
  List<Color> mColors= [
    Colors.red,
    Colors.green,
    Colors.orangeAccent,
    Colors.black,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchAllProductEvent());
    context.read<CategoryBloc>().add(CategoryGetEvent());
  }

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
              SizedBox(height: 11,),
              Expanded(
                flex: 4,
                child: CarouselSlider.builder(
                  itemBuilder: (_, index, _) {
                    return Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(mBanners[index]),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 150,
                          bottom: 8,
                          child: SliderIndicator(
                            length: mBanners.length,
                            activeIndex: selectedIndex,
                            indicator: Container(
                              width: 6,
                              height: 6,
                              margin:  EdgeInsets.symmetric(horizontal: 4),
                              decoration:  BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            activeIndicator: Container(
                              width: 15,
                              height: 6,
                              margin:  EdgeInsets.symmetric(horizontal: 4),
                              decoration:  BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: mBanners.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayCurve: Curves.bounceIn,
                    autoPlayAnimationDuration: Duration(milliseconds: 300),
                    viewportFraction: 1,
                    onPageChanged: (index, r) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                flex: 2,
                child: BlocBuilder<CategoryBloc,CategoryState>(
                  builder: (context,state) {
                    if(state is CatLoadedState){
                      return  state.allCat.isNotEmpty ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.allCat.length,
                        itemBuilder: (context, index) {
                          var data = state.allCat[index];
                          return InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, AppRoutes.categoryDetailPage,arguments: int.parse(data.id.toString()));

                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      listCos[index % listCos.length]["image"] as String,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                state.allCat[index].name != null ? Text(data.name!): Text(""),
                              ],
                            ),
                          );
                        },
                      ) : Center(child: Text("No Category Found"),);
                    }
                    if(state is CatLoadingState){
                      return Center(child: CircularProgressIndicator());
                    }
                    if(state is CatErrorState){
                      return Center(child: ScaffoldMessenger(child: Text(state.errorMsg)));
                    }
                    return Container();
                  }
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text("Special For You",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, AppRoutes.productDetailPage);
                    }, child: Text("See all",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.mainAppColor),)),
                ],
              ),
              Expanded(
                flex: 5,
                child:  BlocBuilder<ProductBloc,ProductState>(
                  builder: (context,state){
                    if(state is ProductLoadingState){
                      return Center(child: CircularProgressIndicator());
                    }
                    if(state is ProductErrorState){
                      return Center(child: ScaffoldMessenger(child: Text(state.errorMsg)),);
                    }
                    if(state is ProductLoadedState ){

                        return GridView.builder(
                          itemCount: state.allProduct.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4 / 6,
                          ),
                          itemBuilder: (_, index) {
                            var data = state.allProduct[index];
                            return state.allProduct.isNotEmpty ? InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.detailPage,
                                  arguments: data,
                                );
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
                                            color: AppColors.mainAppColor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              topRight: Radius.circular(12),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.favorite_border_rounded,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child:  Image.network(data.image)
                                      ),
                                      Text(data.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      Row(
                                        children: [
                                          Expanded(child: Text(data.price)) ,
                                          mColors.length > 4
                                              ? Row(
                                            children: List.generate(4, (
                                                index,
                                                ) {
                                              if (index == 3) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    left: 2,
                                                  ),
                                                  width: 20,
                                                  height: 20,
                                                  decoration:
                                                  BoxDecoration(
                                                    shape: BoxShape
                                                        .circle,
                                                    border: Border.all(
                                                      color:
                                                      Colors.grey,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "+${mColors.length - 3}",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                        Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    left: 2,
                                                  ),
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    shape:
                                                    BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                      mColors[index],
                                                    ),
                                                  ),
                                                  child: Container(
                                                    margin:
                                                    EdgeInsets.all(1),
                                                    decoration:
                                                    BoxDecoration(
                                                      shape: BoxShape
                                                          .circle,
                                                      color:
                                                      mColors[index],
                                                    ),
                                                  ),
                                                );
                                              }
                                            }),
                                          )
                                              : Row(
                                            children: List.generate(
                                              mColors.length,
                                                  (index) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    left: 2,
                                                  ),
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    shape:
                                                    BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                      mColors[index],
                                                    ),
                                                  ),
                                                  child: Container(
                                                    margin:
                                                    EdgeInsets.all(1),
                                                    decoration:
                                                    BoxDecoration(
                                                      shape: BoxShape
                                                          .circle,
                                                      color:
                                                      mColors[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ) : Center(child: Text("No Meta data found"),);
                          },
                        );

                    }
                    return Container();
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
