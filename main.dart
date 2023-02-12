
import 'package:abdullaa/lay_out/news_app/cubit/states.dart';
import 'package:abdullaa/lay_out/shop_layout/ShopLayout.dart';
import 'package:abdullaa/lay_out/shop_layout/cubit/cubit.dart';
import 'package:abdullaa/lay_out/shop_layout/cubit/states.dart';
import 'package:abdullaa/lay_out/todo_app/cubit.dart';
import 'package:abdullaa/lay_out/todo_app/state.dart';
import 'package:abdullaa/shared/compounant/constant.dart';
import 'package:abdullaa/shared/network/dio_helper.dart';
import 'package:abdullaa/shared/network/network.local.dart';
import 'package:abdullaa/task3.dart';
import 'package:abdullaa/task_2.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lay_out/news_app/cubit/cubit.dart';
import 'moduls/shopApp/login/Shop_Lgin_Screen.dart';
import 'moduls/shopApp/ShopHomeScreens/onBordingScreen.dart';
import 'shared/bloc_observer.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Dio_Helper.init();
  await CashHelper.init();
  Widget ? widget;
  bool ? onBoarding=CashHelper.getData(key: 'onBoarding');
 token = CashHelper.getData(key: 'token');
 print(token);
  if(onBoarding!=null){
    if(token!=null){
      widget=ShopLayout();}
    else
      widget=Shop_Login();
  }else{
    widget=onBoardingScreen();
  }

  runApp( MyApp(
   startWidget:widget,
  ));
}
bool onBoarding=CashHelper.getData(key: 'onBoarding');

class  MyApp extends StatelessWidget {

 final Widget startWidget;

  MyApp({
 required this.startWidget,
});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(
        create: (context) => newsappcubit()
      ..getBusiness()
      ..getSports()
      ..getScience()
      ..getHealth()
        ),
        BlocProvider(
            create:(BuildContext context)=>ShopCubit()
              ..getHomeData()..getCategoryData()..getFavoriteData()..getProfileData(),
        ),
        BlocProvider(
            create:(BuildContext context)=>AppCubit(),
        ),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context ,state){
          return  MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,

              scaffoldBackgroundColor: Colors.white,

              appBarTheme: AppBarTheme(

                iconTheme: IconThemeData(
                    color: Colors.white
                ),
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22,
                ),
                systemOverlayStyle:SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness:Brightness.dark,

                ),
                elevation: 0,
                color: Colors.white,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
              ),
            ),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:  startWidget,
          );
        },

      ),
    );
  }
}
