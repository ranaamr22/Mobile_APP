import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_folder/layout/shop_layout/cubits/shop_states.dart';
import 'package:projects_folder/models/categories_model/categories_model.dart';
import 'package:projects_folder/models/favorites/favorites.dart';
import 'package:projects_folder/modules/cart_screen/cart_screen.dart';
import 'package:projects_folder/modules/favorites_screen/favorites_screen.dart';
import 'package:projects_folder/modules/settings_screen/settings_screen.dart';
import 'package:projects_folder/shared/network/remote/dio_helper.dart';
import '../../../models/favorites/change_favorites.dart';
import '../../../models/home/home_model.dart';
import '../../../modules/home_screen/home_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';


class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState()) ;

  static ShopCubit get(context) => BlocProvider.of(context) ;

  int currentIndex = 0 ;

  List<BottomNavigationBarItem> bottoms = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),

    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Cart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline_sharp),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ] ;
  List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeIndex(int index)
  {
    currentIndex= index ;

    emit(ShopChangeLayoutStateState());
  }

  dynamic homeModel;        // HomeModel
  dynamic favorites = {} ;  // Map<int, bool>
  dynamic itemsInCart = {};
  void getHome()
  {
    emit(ShopHomeLoadingState()) ;
    DioHelper.getData(
      path:HOME,
      token: token
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data) ;

      homeModel.data.products.forEach((element)
      {
        favorites.addAll
        (
          {element.id : element.inFavorites}
        ) ;
        itemsInCart.addAll
          (
            {element.id : element.inCart}
        ) ;
      });

      emit(ShopHomeSuccessState()) ;

    }).catchError((error)
    {
      print(error.toString());
    });
  }

  dynamic categoryModel;    // type: CategoriesModel
  void getCategories()
  {
    emit(ShopCategoriesLoadingState()) ;
    DioHelper.getData(
        path:CATEGORIES,
    ).then((value)
    {
      categoryModel = CategoriesModel.fromJson(value.data) ;
      emit(ShopCategoriesSuccessState()) ;

    }).catchError((error)
    {
      print(error.toString());
    });
  }

  dynamic currentFavorites ;  // type: Favorites
  void getFavorites()
  {
    DioHelper.getData(
      path: FAVORITES,
      token: token
    ).then((value)
    {
      currentFavorites = Favorites.fromJson(value.data) ;
      emit(ShopSuccessGetFavoriteState()) ;
      print(currentFavorites.status) ;

    }).catchError((error)
    {
      print(error.toString()) ;
    });
  }

  dynamic favoriteItem;     // type: ChangeFavorites
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopLoadingChangeProductFavoriteState());

    DioHelper.postData(
        path: FAVORITES,
        data: {
          'product_id': productId
        },
        token: token
    ).then((value) {
      favoriteItem = ChangeFavorites.fromJson(value.data);

      print(favoriteItem.status);
      print(favoriteItem.message);

      if (!favoriteItem.status) {
        favorites[productId] = !favorites[productId]!;
        emit(ShopChangeProductFavoriteSuccessState(favoriteItem));
      }
      else {
        getFavorites();
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopChangeProductFavoriteErrorState());
    });
  }

  dynamic currentItems;
  void getItems()
    {
      DioHelper.getData(
          path: Cart,
          token: token
      ).then((value)
      {
        currentItems = Favorites.fromJson(value.data) ;
        emit(ShopSuccessGetCartState()) ;
        print(currentItems.status) ;

      }).catchError((error)
      {
        print(error.toString()) ;
      });
    }

    dynamic cartItem;     // type: ChangeFavorites
    void changeItems(int productId)
    {
      itemsInCart[productId] = !itemsInCart[productId]! ;
      emit(ShopLoadingChangeProductCartState());

      DioHelper.postData(
          path: Cart,
          data: {
            'product_id' : productId
          },
          token: token
      ).then((value)
      {
        cartItem = ChangeFavorites.fromJson(value.data) ;

        print(cartItem.status) ;
        print(cartItem.message) ;

        if( !cartItem.status )
        {
          itemsInCart[productId] = !itemsInCart[productId]! ;
          emit(ShopChangeProductCartSuccessState(cartItem)) ;
        }
        else
        {
          getItems();
        }

      }).catchError((error)
      {
        print(error.toString()) ;
        emit(ShopChangeProductCartErrorState()) ;
      });

    }




}
