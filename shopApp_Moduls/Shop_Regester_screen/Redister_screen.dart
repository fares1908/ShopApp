import 'package:abdullaa/moduls/shopApp/Shop_Regester_screen/cubit_register/shop_Cubit_register_screen.dart';
import 'package:abdullaa/moduls/shopApp/Shop_Regester_screen/cubit_register/shop_state_register_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../lay_out/shop_layout/ShopLayout.dart';
import '../../../shared/compounant/compounts.dart';
import '../../../shared/compounant/constant.dart';
import '../../../shared/network/network.local.dart';
import '../login/cubit/shop_Cubit_login_screen.dart';
import '../login/cubit/shop_state_login_screen.dart';

class Shop_register_Screen extends StatefulWidget {
  @override
  State<Shop_register_Screen> createState() => _Shop_register_ScreenState();
}

class _Shop_register_ScreenState extends State<Shop_register_Screen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  bool isPasswordShow = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => ShopRegisterCubit(),

        child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
          listener: (context, state) {
            if(state is ShopRegisterSuccessState){

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

          builder:(context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          'Register Now To Browse Our Hot Offer',
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

                          controller: nameController,
                          type: TextInputType.name,
                          label: 'name',
                          icon: Icons.person,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please Enter Your Name';
                            } else {
                              return null;
                            }
                          },

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
                          sofix: isPasswordShow ? Icons.visibility
                              : Icons.visibility_off,
                          suffixPressed: () {
                            setState(() {
                              isPasswordShow = !isPasswordShow;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        deflutformfield(
                          controller: phoneController,
                          type: TextInputType.number,
                          label: 'Phone',
                          icon: Icons.phone,
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please Enter Your Phone';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            height: 45,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              color: Colors.deepPurple,
                              child: Text(
                                'REGISTER',
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

                      ],
                    ),
                  ),
                ),
              ),
            );
          },

        ),
      ),
    );
  }
}
