class Favorites
{
  late bool status ;
  late FavoritesDta data ;

  Favorites.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = FavoritesDta.fromJson(json['data']) ;
  }

}

class FavoritesDta
{
  late int currentPage ;
  late List <FavoritesDataProductModel> data = [];

  FavoritesDta.fromJson(Map<String, dynamic> json)
  {
    currentPage= json['current_page'];

    json['data'].forEach((element)
    {
      data.add(FavoritesDataProductModel.fromJson(element['product'])) ;
    });
  }
}

class FavoritesDataProductModel
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name ;

  FavoritesDataProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
  }
}