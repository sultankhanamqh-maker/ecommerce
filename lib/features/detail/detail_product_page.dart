import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/features/dashboard/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import '../../core/constants/app_colors.dart';
import '../dashboard/presentation/bloc/cart/cart_bloc.dart';
import '../dashboard/presentation/bloc/cart/cart_event.dart';
import '../dashboard/presentation/bloc/cart/cart_state.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

List<String> mBanners = [
  "https://coreldrawdesign.com/resources/previews/preview-special-offer-discount-sale-banner-template-1601301453.webp",
  "https://mir-s3-cdn-cf.behance.net/project_modules/fs/3ce709113389695.60269c221352f.jpg",
  "https://www.shutterstock.com/image-vector/sale-banner-layout-design-vector-260nw-2444547953.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOQyxO9xrltN1zqk0yk8Lq4CkPUWlyTMgXWw&s",
];
class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  int selectedIndex = 0;
  int selectedBannerIndex = 0;
  bool isSelected = false;
  bool isAddToCartLoading = false;
  List<Color> mColor = [
    Colors.red,
    Colors.green,
    Colors.black,
    Colors.yellow,
    Colors.blue,
  ];
  List<Map<String, dynamic>> mTabs = [
    {"name": "Description", "desc": "This is Description Tab"},
    {"name": "Specifications", "desc": "This is Specifications Tab"},
    {"name": "Reviews", "desc": "This is Reviews Tab"},
  ];
  bool isSelectedTabIndex = false;

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
                        Center(child: CarouselSlider.builder(
                          itemBuilder: (_, index, _) {
                                return Container(
                                    width: 300,
                                    height: 300,
                                  padding: EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(

                                      image: NetworkImage(mProduct.image!),
                                    ),),
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
                                selectedBannerIndex = index;
                              });
                            },
                          ),
                        ),),
                        Positioned(
                          left: 160,
                          bottom: 8,
                          child: SliderIndicator(
                            length: mBanners.length,
                            activeIndex: selectedBannerIndex,
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


                        )
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
                                  color: AppColors.mainAppColor,
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
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: isSelected
                                            ? Border.all(
                                          color: mColor[index],
                                          width: 2,
                                        )
                                            : null,
                                      ),
                                      child: isSelected
                                          ? Center(
                                        child: Container(
                                          width: 35,
                                          height: 35,
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
                          SizedBox(height: 7),
                          StatefulBuilder(
                            builder: (context, ss) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                        children: List.generate(mTabs.length, (index) {
                                          final isSelectedTabIndex =
                                              selectedIndex == index;
                                          return InkWell(
                                            onTap: () {
                                              selectedIndex = index;
                                              ss(() {});
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: isSelectedTabIndex
                                                    ? AppColors.mainAppColor
                                                    : null,
                                                borderRadius: BorderRadius.circular(21),
                                              ),
                                              child: Text(
                                                mTabs[index]["name"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: isSelectedTabIndex
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                  Text(mTabs[selectedIndex]["desc"])
                                ],
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
              bottom: 3,
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
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        child: StatefulBuilder(
                          builder: (context, ss) {
                            return Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (quantity > 1) {
                                      quantity--;
                                      ss(() {});
                                    }
                                  },
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "$quantity",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    quantity++;
                                    ss(() {});
                                  },
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      BlocListener<CartBloc, CartState>(
                        listener: (context, state) {
                          if (state is CartLoadingState) {
                            isAddToCartLoading = true;
                          }
                          if (state is CartLoadedState) {
                            isAddToCartLoading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Your Card is add Successfully "),
                              ),
                            );
                            Navigator.pop(context);
                          }
                          if (state is CartErrorState) {
                            isAddToCartLoading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMsg)),
                            );
                          }
                        },
                        child: InkWell(
                          onTap: () {
                            context.read<CartBloc>().add(
                              AddToCartEvent(
                                quantity: quantity,
                                productId: int.parse(mProduct.id!),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(31),
                              color: AppColors.mainAppColor,
                            ),
                            child: Center(
                              child: isAddToCartLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        Text(
                                          "Adding",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
