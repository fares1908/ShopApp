import 'package:abdullaa/lay_out/shop_layout/ShopLayout.dart';
import 'package:abdullaa/moduls/shopApp/Shop_Regester_screen/Redister_screen.dart';
import 'package:abdullaa/moduls/shopApp/login/cubit/shop_Cubit_login_screen.dart';
import 'package:abdullaa/moduls/shopApp/login/cubit/shop_state_login_screen.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/shared/compounant/constant.dart';
import 'package:abdullaa/shared/network/network.local.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Shop_Login extends StatefulWidget {
  @override
  State<Shop_Login> createState() => _Shop_LoginState();
}

class _Shop_LoginState extends State<Shop_Login> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isPasswordShow = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (BuildContext context, state) {
          if(state is ShopLoginSuccessState){

            if(state.loginModel.status==true){
              print(state.loginModel.data!.token);
              print(state.loginModel.message) ;
              CashHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token,)
                  .then((value)
                  {
                    token=state.loginModel.data!.token;
                    navigatAndfinshed(context, ShopLayout());
                  }
              );

            }else{
            showToast(
                text: (state.loginModel.message)!,
                state: ToastStates.ERROR,

            );
              print(state.loginModel.message);

            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          'Login Now To Browse Our Hot Offer',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        deflutformfield(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please Enter Your Email Address';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        deflutformfield(
                          isPassword: isPasswordShow,
                          controller: passwordController,
                          type: TextInputType.number,
                          label: 'Password',
                          icon: Icons.lock,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please Enter Your Password';
                            } else {
                              return null;
                            }
                          },
                          sofix: isPasswordShow ? Icons.visibility         : Icons.visibility_off,
                          suffixPressed: () {
                            setState(() {
                              isPasswordShow = !isPasswordShow;
                            });
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            height: 45,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              color: Colors.deepPurple,
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          fallback: (BuildContext context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, Shop_register_Screen());
                              },
                              child: Text('REGISTER'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
