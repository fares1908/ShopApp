import 'package:abdullaa/models/ShopModelss/ShopLoginModel.dart';

abstract class ShopRegisterState {}
class ShopRegisterInitialState extends ShopRegisterState {}
class ShopRegisterLoadingState extends ShopRegisterState {}
class ShopRegisterSuccessState extends ShopRegisterState {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}
class ShopRegisterErrorState extends ShopRegisterState {
  late final String error;
  ShopRegisterErrorState(this.error);
}