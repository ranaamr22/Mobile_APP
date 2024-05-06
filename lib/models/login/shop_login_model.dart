class ShopLoginModel
{
  late bool status;
  late String message;
  dynamic data ;

  ShopLoginModel.fromJSON(Map<String, dynamic> json)
  {
    status  = json['status'];
    message = json['message'];

    if (json['data'] != null)
    {
      data = ShopLoginDataModel.fromJSON(json['data']);
    }
  }
}

class ShopLoginDataModel
{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  ShopLoginDataModel.fromJSON(Map<String, dynamic> json)
  {
    image  = json['image'] ;
    name   = json['name'] ;
    email  = json['email'] ;
    phone  = json['phone'] ;
    points = json['points'] ;
    credit = json['credit'] ;
    token  = json['token'] ;
    id     = json['id'] ;
  }
}
