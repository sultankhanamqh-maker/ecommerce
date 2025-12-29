abstract class UserEvent{}

class UserRegisterEvent extends UserEvent{
  String name;
  String mobNo;
  String email;
  String password;

  UserRegisterEvent({required this.email,required this.password,required this.name,required this.mobNo});
}

class UserLoginEvent extends UserEvent{
  String email;
  String password;

  UserLoginEvent({required this.password,required this.email});
}