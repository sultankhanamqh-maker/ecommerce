import 'package:ecommerce/features/dashboard/data/model/category_model.dart';

abstract class CategoryState {}

class CatInitialState extends CategoryState{}

class CatLoadingState extends CategoryState{}

class CatLoadedState extends CategoryState{
  List<CategoryModel> allCat;
  CatLoadedState({required this.allCat});
}

class CatErrorState extends CategoryState{
  String errorMsg;
  CatErrorState({required this.errorMsg});
}