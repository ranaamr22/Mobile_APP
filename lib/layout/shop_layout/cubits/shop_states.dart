import '../../../models/favorites/change_favorites.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeLayoutStateState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeErrorState extends ShopStates {}

class ShopCategoriesLoadingState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {}

class ShopLoadingChangeProductFavoriteState extends ShopStates {}
class ShopLoadingChangeProductCartState extends ShopStates {}

class ShopChangeProductFavoriteSuccessState extends ShopStates
{
  final ChangeFavorites model ;
  ShopChangeProductFavoriteSuccessState(this.model) ;
}
class ShopChangeProductCartSuccessState extends ShopStates
{
  final ChangeFavorites model ;
  ShopChangeProductCartSuccessState(this.model) ;
}

class ShopChangeProductFavoriteErrorState extends ShopStates {}
class ShopChangeProductCartErrorState extends ShopStates {}

class ShopLoadingGetFavoriteState extends ShopStates {}

class ShopSuccessGetFavoriteState extends ShopStates {}
class ShopSuccessGetCartState extends ShopStates {}

class ShopErrorGetFavoriteState extends ShopStates {}