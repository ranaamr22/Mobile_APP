import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_folder/layout/shop_layout/cubits/shop_cubit.dart';
import 'package:projects_folder/layout/shop_layout/cubits/shop_states.dart';
import 'package:projects_folder/shared/styles/colors.dart';

import '../../models/favorites/favorites.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(

      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = ShopCubit.get(context);

        if(cubit.homeModel != null)
        {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  favoriteListBuilder(cubit.currentFavorites.data.data[index], context),

              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                child: Container(
                  color: Colors.grey[350],
                  width: double.infinity,
                  height: 1,
                ),
              ),

              itemCount: cubit.currentFavorites.data.data.length,
            );
        }
        else
        {
          return const Center(child: CircularProgressIndicator(color: mainColor,));
        }
      }
    );
  }

  Widget favoriteListBuilder (FavoritesDataProductModel model, context) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 120.0,
      child: Row(
        children: [
          // The image of the product
         Image(
            image: NetworkImage(model.image),
            height: 90,
            width: 90,
          ),

          const SizedBox(width: 10.0,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The title of the product
               Text(
                  model.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const Spacer() ,

                // The price, favorite and cart icon of the product
                Row(
                  children: [
                   Column(
                      children: [
                        Text(
                          '${model.price}',
                          style: const TextStyle(
                              fontSize: 15,
                              color: mainColor
                          ),
                        ),

                        // only if there is offer print the old price
                        if(model.price < model.oldPrice) Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // The Cart Icon Button
                    IconButton(
                      onPressed: ()
                      {

                      } ,
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        size: 20,
                      ),
                    ),

                    // The favorite icon button
                    IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      // ignore: prefer_const_constructors
                      icon: Icon(
                        ShopCubit.get(context).favorites[model.id] ? Icons.favorite : Icons.favorite_outline_sharp,
                        size: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}