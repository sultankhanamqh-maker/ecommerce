
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/core/services/api_services.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/profile/profile_event.dart';
import 'package:ecommerce/features/dashboard/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_urls.dart';
import '../../../data/model/profile_model.dart';

class ProfileBloc  extends Bloc<ProfileEvent,ProfileState>{
  ApiServices apiServices;
  ProfileBloc({required this.apiServices}) : super(ProfileInitialState()){
    
    on<GetProfileEvent>(_getProfile);
  
    
  }
  
  
 Future<void> _getProfile(GetProfileEvent event , Emitter<ProfileState> emit)async{
    emit(ProfileLoadingState());
    try{
      var res = await apiServices.postApi(url: AppUrls.getProfileUrl,mBody: {
        "user_id": AppConstants.tokenLoginKey
      });
      if(res["status"]== true || res["status"]=="true"){
         emit(ProfileLoadedState(allProfile: ProfileModel.fromJson(res["data"])));
      }
      else{
        emit(ProfileErrorState(errorMsg: res["message"]));
      }
    }
    catch(e){
       emit(ProfileErrorState(errorMsg: e.toString()));
    }
  }


}




    
    
    
