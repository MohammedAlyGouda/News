import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_one_flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:new_one_flutter_app/layout/shop_app/shop_layout.dart';
import 'package:new_one_flutter_app/modules/shop_app/onboarding/on_boarding_screen.dart';
import 'package:new_one_flutter_app/modules/shop_app/shop_login_screen/shop_login_screen.dart';
import 'package:new_one_flutter_app/shared/bloc_observer.dart';
import 'package:new_one_flutter_app/shared/components/constants.dart';
import 'package:new_one_flutter_app/shared/cubit/cubit.dart';
import 'package:new_one_flutter_app/shared/cubit/states.dart';
import 'package:new_one_flutter_app/shared/network/local/cache_helper.dart';
import 'package:new_one_flutter_app/shared/network/remote/dio_helper.dart';
import 'package:new_one_flutter_app/shared/styles/theme.dart';

import 'layout/news_app/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget;
  bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: ShopLayout(),
            //startWidget,
          );
        },
      ),
    );
  }
}
