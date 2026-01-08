import 'package:ecommerce/core/constants/app_urls.dart';
import '../../../../core/services/api_services.dart';
import 'package:dartz/dartz.dart';


abstract class CartRepository {
  Future<void> addToCart({required int productId,required int quantity});
  Future<void> createOrder({required  productId});
  Future<void> viewCart();
  Future<void> deleteCartItem({required String cartId});
}

class CartRepositoryImplement extends CartRepository {

  final ApiServices apiServices;
  CartRepositoryImplement({required this.apiServices});

  @override
  Future<Either<String,void>> addToCart({required int productId, required int quantity}) async{
    try {
      var res = await apiServices.postApi(url: AppUrls.addToCartUrl, mBody: {
        "product_id": 2,
        "quantity": 1
      });
      if (res["status"] == true || res["status"] == "true") {
        return Right(null);
      }
      else {
        return Left(res["message"]);
      }
    }
      catch(e){
      return Left(e.toString());

    }
  }

  @override
  Future<void> createOrder({required productId}) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCartItem({required String cartId}) {
    // TODO: implement deleteCartItem
    throw UnimplementedError();
  }

  @override
  Future<void> viewCart() {
    // TODO: implement viewCart
    throw UnimplementedError();
  }

}