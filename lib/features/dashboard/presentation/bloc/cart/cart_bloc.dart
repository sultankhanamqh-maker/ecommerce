import 'package:ecommerce/features/dashboard/data/model/cart_model.dart';
import 'package:ecommerce/features/dashboard/data/repository/cart_repository.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/cart/cart_event.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/services/api_services.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ApiServices apiServices;

  CartBloc({required this.apiServices}) : super(CartInitialState()) {
    on<AddToCartEvent>(_addToCart);
    on<ViewCartEvent>(_viewCart);
    on<CreateOrderEvent>(_createOrder);
    on<DeleteCartEvent>(_deleteCart);
    on<DecrementCartEvent>(_decrementCart);
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      var res = await apiServices.postApi(url: AppUrls.addToCartUrl, mBody: {
        "product_id": event.productId,
        "quantity": event.quantity
      });
      if (res["status"] == true || res["status"] == "true") {
        emit(CartLoadedState());
      }
      else {
        emit(CartErrorState(errorMsg: res["message"]));
      }
    }
    catch(e){
      emit(CartErrorState(errorMsg: e.toString()));

    }
  }
  Future<void> _viewCart(ViewCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      var res = await apiServices.getApi(url: AppUrls.viewCartUrl, );
      if (res["status"] == true || res["status"] == "true") {
        var data = res["data"];
        List<CartViewModel> allCart = [];
        for (var eachItem in data) {
          allCart.add(CartViewModel.fromJson(eachItem));
        }

        emit(CartLoadedState(allCart: allCart));
      }
      else {
        emit(CartErrorState(errorMsg: res["message"]));
      }
    }
    catch(e){
      emit(CartErrorState(errorMsg: e.toString()));
    }
  }
  Future<void> _createOrder(CreateOrderEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      var res = await apiServices.postApi(url: AppUrls.createOrderUrl, mBody: {
        "product_id":event.productId,
        "status":event.status
      });
      if (res["status"] == true || res["status"] == "true") {
        emit(CartCheckoutSuccessState());
      }
      else {
        emit(CartErrorState(errorMsg: res["message"]));
      }
    }
    catch(e){
      emit(CartErrorState(errorMsg: e.toString()));
    }
  }
  Future<void> _deleteCart(DeleteCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      var res = await apiServices.postApi(url: AppUrls.deleteOrderUrl, mBody: {
        "cart_id": event.catId
      });
      if (res["status"] == true || res["status"] == "true") {
        add(ViewCartEvent());
      }
      else {
        emit(CartErrorState(errorMsg: res["message"]));
      }
    }
    catch(e){
      emit(CartErrorState(errorMsg: e.toString()));
    }
  }
  Future<void> _decrementCart(DecrementCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      var res = await apiServices.postApi(url: AppUrls.decrementQuantityUrl, mBody: {
        "product_id": event.productId,
        "quantity": event.quantity
      });
      if (res["status"] == true || res["status"] == "true") {
        add(ViewCartEvent());
      }
      else {
        emit(CartErrorState(errorMsg: res["message"]));
      }
    }
    catch(e){
      emit(CartErrorState(errorMsg: e.toString()));

    }
  }
}
