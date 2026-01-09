import 'package:ecommerce/features/dashboard/data/model/cart_model.dart';
import 'package:equatable/equatable.dart';
abstract class CartState extends Equatable{
  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartState{}

class CartLoadingState extends CartState{}

class CartLoadedState extends CartState{
  final List<CartViewModel>? allCart;
  final int? updatingProductId;

  CartLoadedState({this.allCart,this.updatingProductId});
  @override
   List<Object?> get props => [allCart,updatingProductId];
}


class CartErrorState extends CartState{

  String errorMsg;
  CartErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class CartCheckoutSuccessState extends CartState{}