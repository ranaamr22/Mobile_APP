// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_folder/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:projects_folder/shared/components/components.dart';
import 'package:projects_folder/shared/components/constants.dart';
import 'package:projects_folder/shared/network/local/cashe_helper.dart';
import 'package:projects_folder/shared/styles/colors.dart';

import '../../layout/shop_layout/shop_layout.dart';
import '../register_screen/register_screen.dart';
import 'login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state)
        {
          if(state is LoginSuccessState)
          {
            if(state.loginModel.status)
            {
              showToast(
                state: ToastColor.success,
                text: state.loginModel.message
              );
              CasheHelper.setData(key: 'token', value: state.loginModel.data.token) ;
              CasheHelper.setData(key: 'image', value: state.loginModel.data.image) ;
              CasheHelper.setData(key: 'name', value: state.loginModel.data.name) ;
              token = state.loginModel.data.token;
              navigateToAndRemove(context, ShopLayout()) ;
            }
            else
            {
              showToast(
                text: state.loginModel.message,
                state: ToastColor.error,
              );
            }
          }
        },
        builder: (context, state)
        {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        child: Image(
                          height: 200,
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/onboarding_1.png',
                          ),
                        ),
                      ),
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        'Login to browse our hot offers',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 30,),

                      defaultTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        prefix: Icon(Icons.email_outlined),
                        label: 'E-mail',
                        controller: emailController,
                        validate: (value)
                        {
                          if (value.toString().isEmpty) {
                            return 'Enter your E-mail';
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 15.0,
                      ),

                      defaultTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        prefix: Icon(Icons.lock_outline_sharp),
                        label: 'password',
                        controller: passwordController,
                        isPassword: cubit.isPassword ,
                        validate: (value)
                        {
                          if(value.toString().isEmpty)
                          {
                            return 'Password is to short' ;
                          }
                          return null ;
                        },
                        suffix: IconButton(
                          onPressed: ()
                          {
                            cubit.changePasswordVisibility();
                          },
                          icon: cubit.suffix,
                        ),
                        onSubmit: (value)
                        {
                          if(formKey.currentState!.validate())
                          {
                            cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),

                      SizedBox(height: 15.0,),

                      cubit.isCheckReceived ?  defaultButton(
                        onPress: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                                lang: 'en'
                            );
                          }
                        },
                        label: 'login',
                      ) : Center(child: CircularProgressIndicator(color: mainColor,)) ,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t Have Account ?'),

                          TextButton(
                            onPressed: ()
                            {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                  color: mainColor
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
