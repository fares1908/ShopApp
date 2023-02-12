import 'package:abdullaa/lay_out/shop_layout/cubit/cubit.dart';
import 'package:abdullaa/lay_out/shop_layout/cubit/states.dart';
import 'package:abdullaa/models/ShopModelss/CategortModel.dart';
import 'package:abdullaa/moduls/shopApp/ShopHomeScreens/ptoducts_screen.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context ,state){},
      builder:(context,state) {
        return  ListView.separated(
          itemBuilder: (context, index) => buildCategoryItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context, index) =>myDivider(),
          itemCount:ShopCubit.get(context).categoriesModel!.data.data.length ,
        );
      },
    );
  }
}
Widget buildCategoryItem(DataModel model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(

    children: [
      Image(
        image:NetworkImage(
          '${model.image}',

        ),
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      ),
      SizedBox(
        width: 15,

      ),
      Text(
        '${model.name}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios,
      ),

    ],
  ),
);