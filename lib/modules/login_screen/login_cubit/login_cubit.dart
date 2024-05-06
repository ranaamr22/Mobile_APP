
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_folder/models/login/shop_login_model.dart';

import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(LoginInitState()) ;

  static LoginCubit get(context) => BlocProvider.of(context) ;

  bool isPassword = true ;
  var suffix = Icon(Icons.visibility);

  void changePasswordVisibility()
  {
    isPassword = !isPassword ;
    suffix = isPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off) ;

    emit(ChangePasswordVisibilityState()) ;
  }

  late ShopLoginModel shopLoginModel ;
  bool isCheckReceived = true ;

  void userLogin({
    required email,
    required password,
    Map<String, dynamic>? queries,
    String? lang= 'en',
  })
  {
    emit(LoginLoadingState()) ;
    isCheckReceived= false ;

    DioHelper.postData(
      path: LOGIN,
      data: {
        'email'    : email,
        'password' : password,
      },
    ).then((value)
    {
      shopLoginModel = ShopLoginModel.fromJSON(value.data);

      print(shopLoginModel.status);
      isCheckReceived= true ;
      emit(LoginSuccessState(shopLoginModel));

    }).catchError((error){

      print(error.toString()) ;
    });
  }
}
