import 'package:ecommerce/features/dashboard/data/model/cart_model.dart';

abstract class CartEvent {
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent{
  int productId;
  int quantity;

  AddToCartEvent({required this.productId,required this.quantity});

  @override
  List<Object?> get props => [productId,quantity];
}


class ViewCartEvent extends CartEvent{}

class CreateOrderEvent extends CartEvent {
  int productId,status;
  CreateOrderEvent({required this.productId,required this.status});

  List<Object?> get props => [productId,status];
}

class DeleteCartEvent extends CartEvent{
  int catId;
  DeleteCartEvent({required this.catId});

  List<Object?> get props => [catId];
}

class DecrementCartEvent extends CartEvent{
  int productId;
  int quantity;

  DecrementCartEvent({required this.productId,required this.quantity});

  @override
  List<Object?> get props => [productId,quantity];
}


