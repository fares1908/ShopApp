import 'package:abdullaa/models/ShopModelss/ShopLoginModel.dart';
import 'package:abdullaa/moduls/shopApp/login/cubit/shop_state_login_screen.dart';
import 'package:abdullaa/shared/network/dio_helper.dart';
import 'package:abdullaa/shared/network/end_points.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{

ShopLoginCubit():super(ShopLoginInitialState());
static ShopLoginCubit get(context)=>BlocProvider.of(context);
    ShopLoginModel ?loginModel;
    void userLogin({
      required String email,
      required String password,
    }){
      emit(ShopLoginLoadingState());
  Dio_Helper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,

      }
  ).then((value) {
    print(value.data);
   loginModel=ShopLoginModel.fromJson(value.data);

 print(loginModel!.data!.image);
    emit(ShopLoginSuccessState(loginModel!));

  }).catchError((error){
    emit(ShopLoginErrorState(error.toString()));
  });
    }
}