// ignore_for_file: unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_folder/layout/shop_layout/cubits/shop_cubit.dart';
import 'package:projects_folder/models/categories_model/categories_model.dart';
import 'package:projects_folder/models/home/home_model.dart';
import 'package:projects_folder/shared/components/components.dart';
import 'package:projects_folder/shared/styles/colors.dart';
import '../../layout/shop_layout/cubits/shop_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    var cubit= ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopChangeProductFavoriteSuccessState)
        {
          if(!state.model.status)
          {
            showToast(text: state.model.message, state: ToastColor.error);
          }
        }
      },
      builder: (context, state)
      {
        if(cubit.homeModel != null && cubit.categoryModel != null)
        {
          return gridViewBuilder(cubit.homeModel, cubit.categoryModel, context);
        }
        else
        {
          return const Center(child: CircularProgressIndicator(color: mainColor,)) ;
        }
      },
    );
  }

  Widget gridViewBuilder (HomeModel model, CategoriesModel category, context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data.banners.map((e) =>
              Image(
                image: NetworkImage(e.image),
                width: double.infinity,
                fit: BoxFit.contain,
              )
          ).toList(),

          options: CarouselOptions(
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),

        const SizedBox(height: 10.0,),

        Padding(
          padding: const EdgeInsets.only(
              left: 20.0,
              top: 10.0,
              bottom: 10.0
          ),
          child: Text(
            'Categories',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
        ),

        Container(
          height: 90.0,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 5.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => categoriesBuilder(category.data.data[index], context),
            separatorBuilder: (context, index) => const SizedBox(width: 7.0,),
            itemCount: ShopCubit.get(context).categoryModel.data.data.length,
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 10.0,
            bottom: 10.0
          ),
          child: Text(
            'Products',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
        ),

        Container(
         color: Colors.grey[300],
         child: Padding(
           padding: const EdgeInsets.all(2.0),
           child: GridView.count(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             crossAxisCount: 2,
             childAspectRatio: 1 / 1.66,
             crossAxisSpacing: 2.0,
             mainAxisSpacing: 2.0,
             children: List.generate(
               model.data.products.length,
               (index) => productBuilder(model.data.products[index], context),
             ),
           ),
         ),
       ),
      ],
    ),
  );

  Widget productBuilder (HomeDataProductModel product, context) =>
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(30.0) ,
        ),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // The image of the product and the discount alert
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    height: 150,
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      product.image,
                    ),
                    width: double.infinity,
                  ),
                  if(product.oldPrice > product.price) Container(
                    color: Colors.red,
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 5.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0,),

            // the name of the product
            Expanded(
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    height: 1
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // the bottom row in the product column ( price, favorites, add to carts )
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0,),
              child: Row(
                children: [

                  //The price of the product area
                  Column(
                    children: [
                      // The latest price of the product
                      Text(
                        '${product.price.round()}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: mainColor,
                        ),
                      ),

                      //only if the is discount add the old price and discount alert
                      if(product.oldPrice > product.price)
                        Text(
                          '${product.oldPrice.round()}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                    ],
                  ),

                  const Spacer(),

                  // The Add to cart icon button
                  IconButton(
                    padding: const EdgeInsetsDirectional.all(0.0),
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeItems(product.id) ;
                    },
                    icon: Icon(
                      ShopCubit.get(context).itemsInCart[product.id] ? Icons.shopping_cart : Icons.add_shopping_cart ,
                      size: 20,
                    ),
                  ),


                  // the favorites button
                  IconButton(
                    padding: const EdgeInsetsDirectional.all(0.0),
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(product.id) ;
                    },
                    icon: Icon(
                      ShopCubit.get(context).favorites[product.id] ? Icons.favorite : Icons.favorite_outline_sharp,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget categoriesBuilder (DataModel model, context) => SizedBox(
    width: 90,
    child: Column(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(model.image),
        ),
        Expanded(
          child: Text(
            model.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
