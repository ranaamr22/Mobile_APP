import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_folder/layout/shop_layout/cubits/shop_cubit.dart';
import 'package:projects_folder/layout/shop_layout/cubits/shop_states.dart';
import 'package:projects_folder/modules/login_screen/login_screen.dart';
import 'package:projects_folder/shared/components/components.dart';
import 'package:projects_folder/shared/network/local/cashe_helper.dart';
import 'package:projects_folder/shared/styles/colors.dart';


class ShopLayout extends StatelessWidget {

  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {

    var cubit = ShopCubit.get(context) ;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(
            leading: getUserProfilePicture(CasheHelper.getData(key: 'image')),
            //titleSpacing: 10.0,
            title: Text(
              'Hi, ${CasheHelper.getData(key: 'name').split(' ')[0] ?? ''}',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: ()
                {
                  CasheHelper.removeData(key: 'token') ;
                  navigateToAndRemove(context, LoginScreen()) ;
                },
                child: const Text(
                  'SIGN OUT',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              )
            ],
          ),

          body: cubit.screens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottoms,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        ) ;
      },
    );
  }

  Widget getUserProfilePicture(String image) => Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: CircleAvatar(
      radius: 30.0,
      backgroundImage: NetworkImage(image),
    ),
  );
}