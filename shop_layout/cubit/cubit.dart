import 'package:abdullaa/lay_out/shop_layout/cubit/states.dart';
import 'package:abdullaa/models/ShopModelss/CategortModel.dart';
import 'package:abdullaa/models/ShopModelss/FavoriteModelScreen.dart';
import 'package:abdullaa/models/ShopModelss/HomeModel.dart';
import 'package:abdullaa/models/ShopModelss/ShopLoginModel.dart';
import 'package:abdullaa/moduls/shopApp/ShopHomeScreens/categoriess.dart';

import 'package:abdullaa/moduls/shopApp/ShopHomeScreens/favorite.dart';
import 'package:abdullaa/moduls/shopApp/ShopHomeScreens/ptoducts_screen.dart';
import 'package:abdullaa/moduls/shopApp/ShopHomeScreens/settingScreen.dart';
import 'package:abdullaa/shared/compounant/constant.dart';
import 'package:abdullaa/shared/network/dio_helper.dart';
import 'package:abdullaa/shared/network/end_points.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ShopModelss/FavoriteModel.dart';

class ShopCubit extends  Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());
 static ShopCubit get(context)=>BlocProvider.of(context);
 List<Widget>bottomScreen=
 [
   ProductScreen(),
   CategoriesScreen(),
   FavoriteScreen(),
   SettingsScreen(),

 ];
int currentIndex=0;
void changScreen(int index){
  currentIndex=index;
  emit(ShopChangeBottomNavState());
}
HomeModel ? homeModel;
Map<int , bool>favourite={};
void getHomeData(){
  emit(ShopLoadingHomeDataState());
  Dio_Helper.getData(
      url: HOME,
      token:token,
  ).then((value) {
    homeModel=HomeModel.fromJson(value.data);
    printFullText(homeModel!.data.toString());
    homeModel!.data!.products.forEach((element)
    {
      favourite.addAll({
        element.id:element.inFavorites,
      });

    });

    emit(ShopSuccessHomeDataState());
  }).catchError((error){
    emit(ShopErrorHomeDataState());
    print(error.toString());
  });
}
  CategoriesModel ?categoriesModel;
  void getCategoryData(){
    Dio_Helper.getData(
      url: SET_CATEGORY,
      token:token,
    ).then((value) {
     categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoryDataState());
    }).catchError((error){
      emit(ShopErrorCategoryDataState());
      print(error.toString());
    });
  }

  ChangeFavoriteModel  ?changeFavoriteModel;
  void changeFavorite(int  productId){
    favourite[productId]=!favourite[productId]!;
    emit(ShopSuccessFavDataState());
    Dio_Helper.postData(
        url: FAVORITE,
        data:{
          'product_id':productId,
        },
      token: token,
    ).then((value) {
      changeFavoriteModel=ChangeFavoriteModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoriteModel!.status!){
        favourite[productId]=!favourite[productId]!;
      }else{
        getFavoriteData();
      }
       emit(ShopSuccessChangeFavDataState(changeFavoriteModel!));

    }).catchError((error){
      favourite[productId]=!favourite[productId]!;
      emit(ShopErrorChangeFavDataState());
    });
  }
  FavouritesModel ?favouriteModel;
  void getFavoriteData(){
    emit(ShopLoadingFavDataState());
    Dio_Helper.getData(
      url: FAVORITE,
      token:token,
    ).then((value) {
      favouriteModel=FavouritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavDataState());
    }).catchError((error){
      emit(ShopErrorGetFavDataState());
      print(error.toString());
    });
  }
  ShopLoginModel ?userModel;
  void getProfileData(){
    emit(ShopLoadingProfDataState());
    Dio_Helper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {
      userModel=ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name);
      emit(ShopSuccessGetProfDataState());
    }).catchError((error){
      emit(ShopErrorGetProfDataState());
      print(error.toString());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,

  }){
    emit(ShopLoadingUpdateUserState());
    Dio_Helper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name':name,
          'phone':phone,
          'email':email,
        }).then((value) {
      emit(ShopSuccessUpdateUserState(userModel!));
      userModel=ShopLoginModel.fromJson(value.data);

      print('update is ok' );
    }).
    catchError((error)
    {
      emit(ShopErrorUpdateUserState());
      print(error.toString());
    });
  }
}
