import 'package:abdullaa/models/ShopModelss/ShopLoginModel.dart';
import 'package:abdullaa/moduls/shopApp/Shop_Regester_screen/cubit_register/shop_state_register_screen.dart';
import 'package:abdullaa/moduls/shopApp/login/cubit/shop_state_login_screen.dart';
import 'package:abdullaa/shared/network/dio_helper.dart';
import 'package:abdullaa/shared/network/end_points.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{

ShopRegisterCubit():super(ShopRegisterInitialState());
static ShopRegisterCubit get(context)=>BlocProvider.of(context);
    ShopLoginModel ?loginModel;
    void userRegister({
      required String name,
      required String email,
      required String password,
      required String phone,
    }){
      emit(ShopRegisterLoadingState());
  Dio_Helper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,

      }
  ).then((value) {
    print(value.data);
   loginModel=ShopLoginModel.fromJson(value.data);

 print(loginModel!.data!.image);
    emit(ShopRegisterSuccessState(loginModel!));

  }).catchError((error){
    emit(ShopRegisterErrorState(error.toString()));
  });
    }
}