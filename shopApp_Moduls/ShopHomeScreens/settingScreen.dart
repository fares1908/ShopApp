import 'package:abdullaa/lay_out/shop_layout/cubit/cubit.dart';
import 'package:abdullaa/lay_out/shop_layout/cubit/states.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/shared/compounant/constant.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  dynamic nameController=TextEditingController();
  dynamic emailController=TextEditingController();
  dynamic PhoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model=ShopCubit.get(context).userModel;
          if(model !=null){
            nameController.text=model.data!.name ;
            PhoneController.text=model.data!.phone!;
            emailController.text=model.data!.email!;

          }
         return  ConditionalBuilder(
           builder: (context) => Center(
             child: SingleChildScrollView(
               // physics: BouncingScrollPhysics(),

               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(
                   key: formKey,
                   child: Column(

                     children: [
                       if(state is   ShopLoadingUpdateUserState)
                         LinearProgressIndicator(),
                       SizedBox(
                         height: 15,
                       ),
                       deflutformfield(
                         controller: nameController,
                         type: TextInputType.name,
                         label: 'Name',
                         icon: Icons.person,
                         validate: (value) {
                           if(value==null){
                             return'Enter Name';
                           }
                         },
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       deflutformfield(
                         controller: emailController,
                         type: TextInputType.emailAddress,
                         label: 'Email',
                         icon: Icons.email,
                         validate: (value) {
                           if(value==null){
                             return'Enter Email';
                           }
                         },
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       deflutformfield(
                         controller: PhoneController,
                         type: TextInputType.phone,
                         label: 'Phone',
                         icon: Icons.phone,
                         validate: (value) {
                           if(value==null){
                             return'Enter Phone';
                           }
                         },
                       ),
                       SizedBox(
                         height: 15,
                       ),
                       Container(
                         width: double.infinity,
                         height: 40
                         ,
                         decoration: BoxDecoration(
                           color: Colors.indigoAccent,
                           borderRadius: BorderRadius.circular(20),
                         ),
                         child: MaterialButton(
                           onPressed: () {
                           signOut(context);
                           },
                           color: Colors.deepPurple,
                           child: Text(
                             'LOGOUT',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 15,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 15,
                       ),
                       Container(
                         width: double.infinity,
                         height: 40,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                         ),
                         child: MaterialButton(
                           onPressed: () {
                             if(formKey.currentState!.validate()){
                               ShopCubit.get(context).updateUserData(
                                 name: nameController.text,
                                 phone: PhoneController.text,
                                 email: emailController.text,
                               );
                             }
                           },
                           color: Colors.deepPurple,
                           child: Text(
                             'UPDATE',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 15,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             ),
           ),
           condition: ShopCubit.get(context).userModel !=null,
           fallback:  (context) => Center(child: CircularProgressIndicator()),
         );
        },

      ),

    );
  }
}
