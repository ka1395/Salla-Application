class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = HomeDataModel.fromJson(json["data"]);
  }
}

class HomeDataModel {
  List banners = [];
  List products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json["banners"].forEach((element) {
      banners.add(BannerDataModel.fromJson(element));
    });
    json["products"].forEach((element) {
      products.add(ProductDataModel.fromJson(element));
    });
  }
}

class BannerDataModel {
  int? id;
  String? image;
  BannerDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}

class ProductDataModel {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;
  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    old_price = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    in_favorites = json["in_favorites"];
    in_cart = json["in_cart"];
  }
}
