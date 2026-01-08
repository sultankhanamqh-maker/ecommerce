import 'package:ecommerce/core/constants/app_colors.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/features/orders/presentation/bloc/order_event.dart';
import 'package:ecommerce/features/orders/presentation/bloc/order_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/order_bloc.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  DateFormat df = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetOrderEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainAppColor,
      appBar: AppBar(
        title: Text("My Orders"),
        centerTitle: true,
        backgroundColor: AppColors.mainAppColor,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is OrderErrorState) {
            return Center(child: Text(state.errMsg));
          }
          if (state is OrderLoadedState) {
            return state.allOrders.isNotEmpty
                ? ListView.builder(
                    itemCount: state.allOrders.length,
                    itemBuilder: (context, index) {
                      var data = state.allOrders[index];
                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You have ordered at : ",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                df.format(DateTime.parse(data.created_at!)),
                                style: TextStyle(color: Colors.grey),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.greyAppColor,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: data.product!.length,
                                  itemBuilder: (context, childIndex) {
                                    var childData = data.product![childIndex];
                                    return data.product!.isNotEmpty
                                        ? Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      data
                                                          .product![childIndex]
                                                          .image!,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Item Name : ${childData.name ?? ""}",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Item Price : ${childData.price ?? ""}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Item Count : ${childData.quantity ?? ""}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Container();
                                  },
                                ),
                              ),
                              Text(
                                "Ordered Id : ${data.order_number}",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.mainAppColor,
                                    ),
                                    child: Text(
                                      "To Pay : ${data.total_amount}",
                                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: Text("No Orders yet"));
          }
          return Container();
        },
      ),
    );
  }
}
