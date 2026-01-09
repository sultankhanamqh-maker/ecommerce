import 'package:ecommerce/features/dashboard/data/model/product_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState{}

class ProductLoadingState extends ProductState{}

class ProductLoadedState extends ProductState{
  final int? productId;
  List<ProductModel> allProduct;
  ProductLoadedState({required this.allProduct,  this.productId});
}

class ProductErrorState extends ProductState{
  String errorMsg;
  ProductErrorState({required this.errorMsg});
}
