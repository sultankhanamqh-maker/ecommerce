import 'package:ecommerce/features/orders/data/model/order_model.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState{}
class OrderLoadingState extends OrderState{}
class OrderLoadedState extends OrderState{
  List<OrderModel> allOrders;
  OrderLoadedState({required this.allOrders});
}
class OrderErrorState extends OrderState{
  String errMsg;
  OrderErrorState({required this.errMsg});
}