// ignore_for_file: use_key_in_widget_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_folder/layout/shop_layout/shop_layout.dart';
import 'package:projects_folder/modules/login_screen/login_screen.dart';
import 'package:projects_folder/shared/components/constants.dart';
import 'package:projects_folder/shared/network/local/cashe_helper.dart';
import 'package:projects_folder/shared/network/remote/dio_helper.dart';
import 'package:projects_folder/shared/styles/colors.dart';

import 'layout/shop_layout/cubits/shop_cubit.dart';
import 'modules/onboarding/onboarding_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.dioInit();
  await CasheHelper.init() ;


  dynamic onBoarding = CasheHelper.getData(key: 'onBoarding');
  token = CasheHelper.getData(key: 'token') ;

  late Widget widget ;

  if(onBoarding != null)
  {
    if(token != null)
    {
      widget =  const ShopLayout() ;
    }
    else
    {
      widget =  LoginScreen() ;
    }
  }
  else
  {
    widget=  OnBoardingScreen() ;
  }

  runApp(
    MyApp(
      startWidget: widget,
    )
  );
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  const MyApp(
  {
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> ShopCubit()..getHome()..getCategories()..getFavorites(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: mainColor,
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: TextStyle(
                color: Colors.grey
            ),
            elevation: 200.0,
          ),
          primarySwatch: mainColor,
          floatingActionButtonTheme:
          const FloatingActionButtonThemeData(
            backgroundColor: mainColor,
            foregroundColor: Colors.white,
            shape: CircleBorder(),
          ),
        ),

        home: startWidget,
      ),
    );
  }
}
