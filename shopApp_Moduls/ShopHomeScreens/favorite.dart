import 'package:abdullaa/lay_out/shop_layout/cubit/states.dart';
import 'package:abdullaa/models/ShopModelss/FavoriteModelScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../lay_out/shop_layout/cubit/cubit.dart';
import '../../../shared/compounant/compounts.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit ,ShopStates>(
      listener:(context, state) {} ,
      builder:(context, state) {
       return  ConditionalBuilder(
         builder: (context) => ListView.separated(
           itemBuilder:(context, index) => buildProductItems(ShopCubit.get(context).favouriteModel!.data!.data[index].product, context),
           separatorBuilder:(context, index) =>myDivider() ,
           itemCount: ShopCubit.get(context).favouriteModel!.data!.data.length,
         ),
         fallback: (context) =>Center(child: CircularProgressIndicator()) ,
         condition: state is! ShopLoadingFavDataState,

       );
      } ,

    );
  }
}
