import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/homeLayout/shopeHomeLayoutScreen.dart';
import 'package:salla/shared/network/local/cashmemory.dart';

import 'modules/Onborading/on_borading_screen.dart';
import 'modules/login/login_screen.dart';
import 'shared/app_cubit/cubit.dart';
import 'shared/app_cubit/myBlockObserver.dart';
import 'shared/app_cubit/stats.dart';
import 'shared/components/constants.dart';
import 'shared/network/rempte/dio.dart';
import 'shared/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CashHelper.init();

  var isOnBorad = CashHelper.getData(key: "onBorading");
  token = CashHelper.getData(key: "token") ?? '';
  print(token);
  Widget screen;

  if (isOnBorad != null) {
    if (token != '') {
      screen = ShopeHomeLayoutScreen();
    } else {
      screen = LoginScreen();
    }
  } else {
    screen = OnBordingScreen();
  }

  runApp(MyApp(
    currentScreen: screen,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.currentScreen});
  final Widget currentScreen;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => ShopeCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritiesData()
              ..getUserData()),
      ],
      child: BlocConsumer<ShopeCubit, ShopeStats>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeDataLight,
            home: currentScreen,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
