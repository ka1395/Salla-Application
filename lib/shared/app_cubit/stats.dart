import '../../models/favorites/getFavoritesModel.dart';

abstract class ShopeStats {}

class ShopeInitialStats extends ShopeStats {}

class ShopeChangeBottomNavrStats extends ShopeStats {}

class ShopeSuccessStats extends ShopeStats {}

class ShopeLoadingStats extends ShopeStats {}

class ShopeErrorStats extends ShopeStats {
  final Error;

  ShopeErrorStats(this.Error);
}

class CategoriesSucssesStats extends ShopeStats {}

class CategoriesErrorStats extends ShopeStats {
  final Error;

  CategoriesErrorStats(this.Error);
}

class ShopeFavoritesChangeStats extends ShopeStats {}

class ShopeFavoritesSucssesChangeStats extends ShopeStats {
  final FavoritesModel;

  ShopeFavoritesSucssesChangeStats(this.FavoritesModel);
}

class ShopeFavoritesErrorChangeStats extends ShopeStats {
  final Error;

  ShopeFavoritesErrorChangeStats(this.Error);
}

class ShopeGetFavoritesLoadingStats extends ShopeStats {}

class ShopeGetFavoritesSuccessStats extends ShopeStats {
  final GetFavortiesModel getFavoritiesModel;

  ShopeGetFavoritesSuccessStats(this.getFavoritiesModel);
}

class ShopeGetFavoritesErrorStats extends ShopeStats {
  final Error;

  ShopeGetFavoritesErrorStats(this.Error);
}

class ShopeGetUserDataLoadingStats extends ShopeStats {}

class ShopeGetUserDataSuccessStats extends ShopeStats {
  final userData;

  ShopeGetUserDataSuccessStats(this.userData);
}

class ShopeGetUserDataErrorStats extends ShopeStats {
  final Error;

  ShopeGetUserDataErrorStats(this.Error);
  
}


class ShopePutUserDataLoadingStats extends ShopeStats {}
class ShopePutUserDataSuccessStats extends ShopeStats {}
class ShopePutUserDataErrorStats extends ShopeStats {
  final Error;
  ShopePutUserDataErrorStats(this.Error);
}







class ShopeLogOutStats extends ShopeStats {}
