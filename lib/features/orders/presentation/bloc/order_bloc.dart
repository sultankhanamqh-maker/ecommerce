import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/core/constants/app_urls.dart';
import 'package:ecommerce/core/services/api_services.dart';
import 'package:ecommerce/features/orders/data/model/order_model.dart';
import 'package:ecommerce/features/orders/presentation/bloc/order_event.dart';
import 'package:ecommerce/features/orders/presentation/bloc/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>{
  ApiServices apiServices;
  OrderBloc({required this.apiServices}) : super(OrderInitialState()){

    on<GetOrderEvent>(_getOrder);
  }

  Future<void> _getOrder(GetOrderEvent event , Emitter<OrderState> emit)async{

    try{
      var res = await apiServices.postApi(url: AppUrls.getOrdersUrl, mBody:
      {
        "user_id":AppConstants.tokenLoginKey
      }
      );
      if(res["status"] == true || res["status"] == "true"){
        List<OrderModel> allOrders = [];
        for(var eachOrder in res["orders"]){
          allOrders.add(OrderModel.fromJson(eachOrder));
        }
        emit(OrderLoadedState(allOrders: allOrders));
      }
      else{
        emit(OrderErrorState(errMsg: res["message"]));
      }
    }
    catch(e){
      emit(OrderErrorState(errMsg: e.toString()));
    }


  }


}