import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/core/constants/app_urls.dart';
import 'package:ecommerce/core/services/api_services.dart';
import 'package:ecommerce/features/on_boarding/presentation/bloc/user_event.dart';
import 'package:ecommerce/features/on_boarding/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  ApiServices apiServices;

  UserBloc({required this.apiServices}) : super(UserInitialState()) {
    on<UserRegisterEvent>((event, emit) async {
      emit(UserLoadedState());
      try {
        var response = await apiServices.postApi(
            url: AppUrls.signupUrl, mBody: {
          "name": event.name,
          "mobile_number": event.mobNo,
          "email": event.email,
          "password": event.password
        });
        if (response["status"]== true) {
          emit(UserLoadedState());
        }
        else {
          emit(UserErrorState(errorMsg: response["message"]));
        }
      }
      catch (e) {
        emit(UserErrorState(errorMsg: e.toString()));
      }
    });

    on<UserLoginEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        var response = await apiServices.postApi(url: AppUrls.loginUrl, mBody: {
          "email": event.email,
          "password": event.password
        });
        if (response["status"] == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(AppConstants.tokenLoginKey, response["tokan"]);
          emit(UserLoadedState());
        }
        else {
          emit(UserErrorState(errorMsg: response["message"]));
        }
      }
      catch (e) {
        emit(UserErrorState(errorMsg: e.toString()));
      }
    });
  }
}