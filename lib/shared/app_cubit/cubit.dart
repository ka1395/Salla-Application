import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/categories/CategoriesModel.dart';
import 'package:salla/modules/categories/categoriesScreen.dart';
import 'package:salla/modules/favorites/favoritesScreen.dart';
import 'package:salla/modules/prodects/prodectsScreen.dart';
import 'package:salla/modules/settings/settingsScreen.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/rempte/dio.dart';

import '../../models/favorites/favoritesModel.dart';
import '../../models/favorites/getFavoritesModel.dart';
import '../../models/login/shopeLoginModel.dart';
import '../../models/shope/homeModel.dart';
import '../../modules/login/login_screen.dart';
import '../network/local/cashmemory.dart';
import '../network/rempte/endPoint.dart';
import 'stats.dart';

class ShopeCubit extends Cubit<ShopeStats> {
  ShopeCubit() : super(ShopeInitialStats());

  static ShopeCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;
  List screensBottomNav = [
    prodectsScreen(),
    CateforiesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];
  void changeIndex(index) {
    CurrentIndex = index;
    emit(ShopeChangeBottomNavrStats());
  }

  HomeModel? homeModel;
  Map<int, bool> favorits = {};

  void getHomeData() {
    emit(ShopeLoadingStats());
    DioHelper.get(url: HOME, token: token).then((value) {
      emit(ShopeSuccessStats());
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorits.addAll({element.id: element.in_favorites});
      });

      getFavoritiesData();
    }).catchError((Error) {
      print(Error);

      emit(ShopeErrorStats(Error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.get(url: GeT_CATRGORIES, token: token).then((value) {
      emit(CategoriesSucssesStats());
      categoriesModel = CategoriesModel.fromJson(value.data);
    }).catchError((Error) {
      print(Error);

      emit(CategoriesErrorStats(Error));
    });
  }

  FavoritesModel? favoritesModel;
  void changeFavorites(int id) {
    emit(ShopeFavoritesChangeStats());

    favorits[id] = !favorits[id]!;
    DioHelper.post(url: FAVORITES, data: {"product_id": id}, token: token)
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      if (!favoritesModel!.status!) {
        favorits[id] = !favorits[id]!;
      } else {
        getFavoritiesData();
      }
      emit(ShopeFavoritesSucssesChangeStats(favoritesModel));
    }).catchError((Error) {
      print(Error);
      favorits[id] = !favorits[id]!;

      emit(ShopeFavoritesErrorChangeStats(Error));
    });
  }

  GetFavortiesModel? getFavoritiesModel;
  void getFavoritiesData() {
    emit(ShopeGetFavoritesLoadingStats());

    DioHelper.get(url: FAVORITES, token: token).then((value) {
      getFavoritiesModel = GetFavortiesModel.fromJson(value.data);
      emit(ShopeGetFavoritesSuccessStats(getFavoritiesModel!));
    }).catchError((Error) {
      print(Error);

      emit(ShopeGetFavoritesErrorStats(Error));
    });
  }

  ShopeLoginModel? userData;
  void getUserData() {
    emit(ShopeGetUserDataLoadingStats());

    DioHelper.get(url: PROGILE, token: token).then((value) {
      userData = ShopeLoginModel.fromJson(value.data);
      print("token with user data ${userData!.data!.token}");
      emit(ShopeGetUserDataSuccessStats(userData));
    }).catchError((Error) {
      print(Error);

      emit(ShopeGetUserDataErrorStats(Error));
    });
  }

  void putUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopePutUserDataLoadingStats());

    DioHelper.put(url: UPDATE_PROFILE, token: token, data: {
      "name": name,
      "email": email,
      "phone": phone,
    }).then((value) {
      userData = ShopeLoginModel.fromJson(value.data);

      print("token with user data ${userData!.message}");

      print("token with user data ${userData!.data!.token}");
      emit(ShopePutUserDataSuccessStats());
    }).catchError((Error) {
      print(Error);

      emit(ShopePutUserDataErrorStats(Error));
    });
  }

  void logOut(context) {
    CurrentIndex = 0;
    CashHelper.removeData(key: "onBorading");
    CashHelper.removeData(key: "token").then((value) {
      emit(ShopeLogOutStats());
      print("this remove login ${CashHelper.getData(key: "token")}");
      navigateAndFinish(context, LoginScreen());
    });
  }
}
