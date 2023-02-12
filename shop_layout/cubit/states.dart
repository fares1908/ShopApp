import 'package:abdullaa/models/ShopModelss/FavoriteModel.dart';
import 'package:abdullaa/models/ShopModelss/ShopLoginModel.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopSuccessCategoryDataState extends ShopStates{}
class ShopErrorCategoryDataState extends ShopStates{}
class ShopSuccessChangeFavDataState extends ShopStates{
  final ChangeFavoriteModel model;

  ShopSuccessChangeFavDataState(this.model);
}
class ShopSuccessFavDataState extends ShopStates{
}
class ShopErrorChangeFavDataState extends ShopStates{}
class ShopLoadingFavDataState extends ShopStates{}
class ShopSuccessGetFavDataState extends ShopStates{}
class ShopErrorGetFavDataState extends ShopStates{}
class ShopLoadingProfDataState extends ShopStates{}
class ShopSuccessGetProfDataState extends ShopStates{}
class ShopErrorGetProfDataState extends ShopStates{}
class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
  final ShopLoginModel model;

  ShopSuccessUpdateUserState(this.model);
}
class ShopErrorUpdateUserState extends ShopStates{

}
