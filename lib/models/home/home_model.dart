class HomeModel
{
  late bool status ;
  late HomeDataModel data ;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']) ;
  }
}

class HomeDataModel
{
  late List <HomeDataBannerModel> banners = [];
  late List <HomeDataProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(HomeDataBannerModel.fromJson(element)) ;
    });

    json['products'].forEach((element)
    {
      products.add(HomeDataProductModel.fromJson(element));
    });
  }
}

class HomeDataBannerModel
{
  late int id;
  late String image;

  HomeDataBannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image= json['image'] ;
  }
}

class HomeDataProductModel
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name ;
  late bool inFavorites;
  late bool inCart;

  HomeDataProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}