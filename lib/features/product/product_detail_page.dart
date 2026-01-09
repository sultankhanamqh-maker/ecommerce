import 'package:ecommerce/features/dashboard/presentation/bloc/product/product_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_routes/app_routes.dart';
import '../../core/constants/app_colors.dart';
import '../dashboard/presentation/bloc/product/product_event.dart';
import '../dashboard/presentation/bloc/product/product_state.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isSelected = false;
  int selectedIndex = 0;
  List<Color> mColor = [
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductErrorState) {
            return Center(
              child: ScaffoldMessenger(child: Text(state.errorMsg)),
            );
          }
          if (state is ProductLoadedState) {
            return GridView.builder(
              itemCount: state.allProduct.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 6,
              ),
              itemBuilder: (_, index) {
                var data = state.allProduct[index];
                return state.allProduct.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailPage,
                            arguments: data,
                          );
                        },

                        child: Card(
                          color: AppColors.greyAppColor,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 35,
                                  height: 35,
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
                                child:
                                     Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(data.image),
                                      )
                                    ,
                              ),
                              Text(
                                      data.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [

                                         Expanded(child: Text(data.price))
                                       ,

                                    Row(
                                      children: List.generate(mColor.length, (
                                        index,
                                      ) {
                                        return InkWell(
                                          onTap: () {
                                            selectedIndex = index;
                                            setState(() {});
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 2),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: selectedIndex == index
                                                  ? Border.all(
                                                      color: mColor[index],
                                                      width: 2,
                                                    )
                                                  : null,
                                            ),
                                            child: selectedIndex == index
                                                ? Center(
                                                    child: Container(
                                                      width: 18,
                                                      height: 18,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: mColor[index],
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: mColor[index],
                                                    ),
                                                  ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(child: Text("No Meta data found"));
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
