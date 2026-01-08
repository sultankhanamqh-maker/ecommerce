import 'package:ecommerce/core/constants/app_colors.dart';
import 'package:ecommerce/core/ui_helper/custom_widgets/elevated_btn.dart';
import 'package:ecommerce/features/dashboard/data/model/cart_model.dart';
import 'package:ecommerce/features/dashboard/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_event.dart';
import '../../../bloc/cart/cart_state.dart';

class CartNavPage extends StatefulWidget {
  const CartNavPage({super.key});

  @override
  State<CartNavPage> createState() => _CartNavPageState();
}

class _CartNavPageState extends State<CartNavPage> {
  bool isLoading = false;

  /// for placeOrder bloc build
  bool isPlaceOrder = false;
  double total = 0;
  TextEditingController percentController = TextEditingController();
  double subtotal = 0;
  bool isPercentHas = false;
  double subTotalWithPercent = 0.0;

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(ViewCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F6F6),
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 60,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is CartErrorState) {
                  return Center(child: Text(state.errorMsg));
                }
                if (state is CartLoadedState) {
                  final allCart = state.allCart ?? [];

                  if (allCart.isNotEmpty) {
                    subtotal = allCart.fold(
                      0,
                      (sum, item) =>
                          sum + (item.quantity! * int.parse(item.price!)),
                    );
                  }
                  total = subtotal;
                  return Container(
                    color: const Color(0xffF6F6F6),
                    child: allCart.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 5,
                            ),
                            child: ListView.builder(
                              itemCount: allCart.length,
                              itemBuilder: (_, index) {
                                var data = allCart[index];
                                var totalPrice =
                                    data.quantity! * double.parse(data.price!);
                                return Card(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(15),
                                        width: 80,
                                        height: 80,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: AppColors.greyAppColor,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Image.network(
                                          data.image.toString(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data.name ?? "",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    List<int> cartIds = [];
                                                    for(var eachItem in state.allCart!){
                                                      cartIds.add(eachItem.id!);
                                                    }
                                                    context.read<CartBloc>().add(DeleteCartEvent(catId: cartIds[index]));
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_outline,
                                                    color:
                                                        AppColors.mainAppColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              data.name.toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$$totalPrice",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.greyAppColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          if (data.quantity! > 1) {
                                                            context.read<CartBloc>().add(DecrementCartEvent(productId: data.productId!, quantity: data.quantity! - 1));
                                                          }
                                                        },
                                                        child: const Text(
                                                          "-",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Text(
                                                        "${data.quantity}",
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      InkWell(
                                                        onTap: () {
                                                          context.read<CartBloc>().add(DecrementCartEvent(productId: data.productId!, quantity: data.quantity! + 1));
                                                        },
                                                        child: const Text(
                                                          "+",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(child: Text("No meta Data found")),
                  );
                }
                return Container();
              },
            ),
          ),
          Expanded(
            flex: 43,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(31),
                  topLeft: Radius.circular(31),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 11),
                  SizedBox(
                    height: 70,
                    child: TextField(
                      controller: percentController,
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        fillColor: AppColors.greyAppColor,
                        hintText: "Enter Discount here",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        suffix: TextButton(
                          onPressed: () {
                            if (percentController.text != "") {
                              int percent = int.parse(percentController.text);
                              subTotalWithPercent =
                                  subtotal - (subtotal / 100) * percent;
                              isPercentHas = true;
                              setState(() {});
                            }
                          },
                          child: Text(
                            "Apply",
                            style: TextStyle(
                              color: AppColors.mainAppColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Subtotal",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Text(
                        "\$${subtotal.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: AppColors.greyAppColor, thickness: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Text(
                        "\$${isPercentHas ? subTotalWithPercent.toStringAsFixed(2) : total}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  BlocConsumer<CartBloc, CartState>(
                    listener: (_, state) {
                      if (state is CartCheckoutSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Order Placed Successfully")),
                        );
                      }
                      if (state is CartLoadingState) {}
                      if (state is CartErrorState) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                      }
                    },
                    builder:(_,state){
                      if(state is CartLoadedState && state.allCart != null){
                        return ElevatedBtn(
                          btnName: "Check Out",
                          onTap: () {
                            for(var eachItem in state.allCart!){
                              int productId = eachItem.productId!;
                              context.read<CartBloc>().add(CreateOrderEvent(productId: productId,status: 1));}
                          },
                          bgColor: AppColors.mainAppColor,
                          fgColor: Colors.white,
                        );
                      }
                      return Container();
                    }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
