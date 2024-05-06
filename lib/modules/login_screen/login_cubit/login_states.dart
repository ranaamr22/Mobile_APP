import 'package:projects_folder/models/login/shop_login_model.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginSuccessState extends LoginStates
{
  final ShopLoginModel loginModel ;

  LoginSuccessState(this.loginModel);
}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {

  final String error ;
  LoginErrorState(this.error) ;
}

class ChangePasswordVisibilityState extends LoginStates {}