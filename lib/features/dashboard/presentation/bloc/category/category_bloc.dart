import 'dart:math';

import 'package:ecommerce/core/constants/app_urls.dart';
import 'package:ecommerce/core/services/api_services.dart';
import 'package:ecommerce/features/dashboard/data/model/category_model.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/category/category_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  ApiServices apiServices;
  CategoryBloc({required this.apiServices}) : super(CatInitialState()){

    on<CategoryGetEvent>((event,emit)async{
      emit(CatLoadingState());
      try{
        var res =  await apiServices.getApi(url: AppUrls.categoryUrl,);
        if(res["status"]){
          List<dynamic> data = res["data"];
          List<CategoryModel> mData = [];
          for(Map<String,dynamic> eachCat in data){
            mData.add(CategoryModel.fromJson(eachCat));
          }
          emit(CatLoadedState(allCat: mData));
        }
        else{
          emit(CatErrorState(errorMsg: res["message"]));
        }
      }
      catch(e){
        emit(CatErrorState(errorMsg: e.toString()));
      }

    });



  }

}