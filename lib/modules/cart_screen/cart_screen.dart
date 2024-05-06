import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_folder/layout/shop_layout/cubits/shop_cubit.dart';
import 'package:projects_folder/layout/shop_layout/cubits/shop_states.dart';
import 'package:projects_folder/models/categories_model/categories_model.dart';
import 'package:projects_folder/shared/styles/colors.dart';
import 'package:projects_folder/modules/settings_screen/payments_screen.dart';

import '../../models/favorites/favorites.dart';
import '../../shared/components/components.dart';

 class CartScreen extends StatelessWidget {
   const CartScreen({super.key});
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: BlocConsumer<ShopCubit, ShopStates>(
         listener: (context, state) {},
         builder: (context, state) {
           var cubit = ShopCubit.get(context);

           if (cubit.homeModel != null) {
             return ListView.separated(
               physics: const BouncingScrollPhysics(),
               itemBuilder: (context, index) => favoriteListBuilder(
                 cubit.currentFavorites.data.data[index],
                 context,
               ),
               separatorBuilder: (context, index) => Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Container(
                   color: Colors.grey[350],
                   width: double.infinity,
                   height: 1,
                 ),
               ),
               itemCount: cubit.currentFavorites.data.data.length,
             );
           } else {
             return const Center(
               child: CircularProgressIndicator(color: mainColor),
             );
           }
         },
       ),
       bottomNavigationBar: BottomAppBar(
         child: Container(
           width: double.infinity,
           child: ElevatedButton(
             onPressed: () {
               // Navigate to the payment screen
               navigateTo(context,PaymentScreen());
               //Navigator.pushNamed(context, '/payment');
             },
             style: ElevatedButton.styleFrom(
               backgroundColor: mainColor
             ),
             child: Padding(
               padding: EdgeInsets.symmetric(vertical: 12),
               child: Text(
                 'Check out',
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 16,
                 ),
               ),
             ),
           ),
         ),
       ),
     );
   }


   //  @override
  //  Widget build(BuildContext context) {
  //   return BlocConsumer<ShopCubit, ShopStates>(
  //
  //       listener: (context, state) {},
  //       builder: (context, state)
  //       {
  //         var cubit = ShopCubit.get(context);
  //
  //         if(cubit.homeModel != null)
  //         {
  //           return ListView.separated(
  //             physics: const BouncingScrollPhysics(),
  //             itemBuilder: (context, index) =>
  //                 favoriteListBuilder(cubit.currentFavorites.data.data[index], context),
  //
  //             separatorBuilder: (context, index) => Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 10.0,),
  //               child: Container(
  //                 color: Colors.grey[350],
  //                 width: double.infinity,
  //                 height: 1,
  //               ),
  //             ),
  //
  //             itemCount: cubit.currentFavorites.data.data.length,
  //           );
  //         }
  //         else
  //         {
  //           return const Center(child: CircularProgressIndicator(color: mainColor,));
  //         }
  //       }
  //   );
  // }

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
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit, ShopStates>(
//       listener: (context, index) {},
//       builder: (context, index)
//       {
//         if(ShopCubit.get(context).categoryModel != null)
//         {
//           return SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               children:
//               [
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) =>  categoryBuilder(ShopCubit.get(context).categoryModel.data.data[index]),
//                     separatorBuilder: (context, index) => Container(
//                       height: 1.0,
//                       width: double.infinity,
//                       color: Colors.grey,
//                     ),
//                     itemCount: ShopCubit.get(context).categoryModel.data.data.length,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         else
//         {
//           return const Center(child: CircularProgressIndicator(color: mainColor,)) ;
//         }
//       }
//     );
//   }
//
//   Widget categoryBuilder(DataModel model) => Row(
//     children: [
//       Image(
//         image: NetworkImage(model.image),
//         height: 100,
//         width: 100,
//       ),
//       const SizedBox(width: 10.0,),
//       Text(
//         model.name,
//         style: TextStyle(
//             fontSize: 17,
//             fontWeight: FontWeight.w600,
//             color: Colors.black.withOpacity(0.7),
//         ),
//       ),
//       const Spacer(),
//       const Icon(
//           Icons.arrow_forward_ios_sharp
//       )
//     ],
//   );
// }
