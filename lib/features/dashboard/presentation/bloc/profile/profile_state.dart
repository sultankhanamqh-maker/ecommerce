import '../../../data/model/profile_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState{}
class ProfileLoadingState  extends ProfileState{}
class ProfileLoadedState extends ProfileState{
  ProfileModel allProfile;
  ProfileLoadedState({required this.allProfile});

  List<Object?> get props => [allProfile];

}
class ProfileErrorState extends ProfileState{

  String errorMsg;
  ProfileErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

