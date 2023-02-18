class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = CategoriesDataModel.fromJson(json["data"]);
  }
}

class CategoriesDataModel {
  int? current_page;
  List dataCategories = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json["current_page"];

    json["data"].forEach((element) {
      dataCategories.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int? id;
  String? image;
   String? name;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
      name = json["name"];
  }
}
