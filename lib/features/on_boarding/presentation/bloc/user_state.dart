abstract class UserState{}

class UserInitialState extends UserState{}

class UserLoadingState extends UserState{}

class UserLoadedState extends UserState{}

class UserErrorState extends UserState{
  String errorMsg;
  UserErrorState({required this.errorMsg});
}