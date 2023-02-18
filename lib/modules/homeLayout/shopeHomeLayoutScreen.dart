import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/search/searchScreen.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/stats.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/styles/colors.dart';

class ShopeHomeLayoutScreen extends StatelessWidget {
  const ShopeHomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit, ShopeStats>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubite = ShopeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    size: 25,
                  ))
            ],
            title: Text(
              "Salla",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          body: cubite.screensBottomNav[cubite.CurrentIndex],
          bottomNavigationBar: FancyBottomNavigation(
            tabs: [
              TabData(
                iconData: Icons.house_outlined,
                title: "Home",
              ),
              TabData(iconData: Icons.apps, title: "Categories"),
              TabData(
                iconData: Icons.favorite,
                title: "Favorite",
              ),
              TabData(iconData: Icons.settings, title: "Settings"),
            ],
            activeIconColor: defaultColor,
            inactiveIconColor: Colors.white,
            circleColor: Colors.white,
            textColor: Colors.white,
            barBackgroundColor: defaultColor,
            initialSelection: 0,
            onTabChangedListener: (position) {
              cubite.changeIndex(position);
            },
          ),
        );
      },
    );
  }
}
