import 'package:ecommerce/core/constants/app_urls.dart';
import 'package:ecommerce/core/services/api_services.dart';
import 'package:ecommerce/features/dashboard/data/model/product_model.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/product/product_event.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState>{
  ApiServices apiServices;
  ProductBloc({required this.apiServices}) : super (ProductInitialState()){

    on<FetchAllProductEvent>((event,emit)async{
      emit(ProductLoadingState());

      try{
        var res = await apiServices.postApi(url: AppUrls.productUrl);
        if(res["status"]){
           List<dynamic> data = res["data"];
           List<ProductModel> mProduct = [];

           for(Map<String,dynamic> eachProduct in data){
             mProduct.add(ProductModel.fromJson(eachProduct));
           }

           emit(ProductLoadedState(allProduct: mProduct));
        }
        else{
          emit(ProductErrorState(errorMsg: res["message"]));
        }
      }
      catch(e){
         emit(ProductErrorState(errorMsg: e.toString()));
      }
    });
    on<ProductSearchEvent>((event,emit)async{
      emit(ProductLoadingState());
      try{
        var res =  await apiServices.postApi(url: AppUrls.productUrl,mBody: {
          "category_id":event.categoryId.toString()
        });
        if(res["status"]){
          List<dynamic> data = res["data"];
          List<ProductModel> mData = [];
          for(Map<String,dynamic> eachProduct in data){
            mData.add(ProductModel.fromJson(eachProduct));
          }
          emit(ProductLoadedState(allProduct: mData,productId: event.categoryId));
        }
        else{
          emit(ProductErrorState(errorMsg: res["message"]));
        }
      }
      catch(e){
        emit(ProductErrorState(errorMsg: e.toString()));
      }

    });

  }

}