import 'package:abdullaa/lay_out/shop_layout/cubit/cubit.dart';
import 'package:abdullaa/lay_out/shop_layout/cubit/states.dart';
import 'package:abdullaa/moduls/shopApp/search/SearchScreen.dart';
import 'package:abdullaa/moduls/shopApp/login/Shop_Lgin_Screen.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/shared/compounant/constant.dart';
import 'package:abdullaa/shared/network/network.local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ShopLayout extends StatelessWidget {
  @override

  Widget build(BuildContext context ) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context ,state){},
      builder: (context ,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            actions: [
              IconButton(
                  onPressed:(){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,
                  )
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar:Container(
             
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: GNav(
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                gap: 8,
                // currentIndex: cubit.currentIndex,
                onTabChange: (index){
                  cubit.changScreen(index);
                },

                padding: EdgeInsets.all(20),

                tabs:[

                  GButton
                    (icon: Icons.home,
                    text: 'Products',
                  ),
                  GButton(icon: Icons.category,
                    text: 'Categories',
                  ),
                  GButton(icon: Icons.favorite,
                    text: 'Favorite',
                  ),
                  GButton(icon: Icons.settings,
                    text: 'Settings',
                  ),
                ],

              ),
            ),
          ),

        );
      },

    );
  }
}
