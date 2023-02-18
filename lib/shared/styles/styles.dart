import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

double the_size_height(BuildContext context,
    {bool appbar = false, bool appbuttombare = false}) {
  if (appbar == true && appbuttombare == true) {
    print(
        "appBar and  bottomBar${((MediaQuery.of(context).size.height
         - MediaQuery.of(context).padding.top) - 
         AppBar().preferredSize.height -  kBottomNavigationBarHeight)}");

    return (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height -
        kBottomNavigationBarHeight);
  } else if (appbar == true && appbuttombare == false) {
    print(
        "appBar ${((MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - AppBar().preferredSize.height))}");
    return (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height);
  } else {
    print(MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    return (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
  }
}

double the_size_width(BuildContext context) =>
    MediaQuery.of(context).size.width;

ThemeData themeDatadark = ThemeData(
    textTheme: TextTheme(
        titleLarge: TextStyle(
            fontFamily: "Jannah",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white)),
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.black45,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 20,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black45,
        selectedItemColor: defaultColor),
    appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.light),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
ThemeData themeDataLight = ThemeData(
    textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 16),
        titleLarge: TextStyle(
            fontFamily: "Jannah",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white)),
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 30,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        selectedItemColor: defaultColor),
    appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
            systemNavigationBarDividerColor: Colors.black,
            systemNavigationBarColor: Colors.black,
            statusBarBrightness: Brightness.dark),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white));

TextStyle black10bold() => const TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black12bold() => const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black14bold() => const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black16bold() => const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black18bold() => const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black20bold() => const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );

TextStyle black10regular() => const TextStyle(
      fontSize: 10.0,
    );
TextStyle black12regular() => const TextStyle(
      fontSize: 12.0,
    );
TextStyle black14regular() => const TextStyle(
      fontSize: 14.0,
    );
TextStyle black16regular() => const TextStyle(
      fontSize: 16.0,
    );
TextStyle black18regular() => const TextStyle(
      fontSize: 18.0,
    );
TextStyle black20regular() => const TextStyle(
      fontSize: 20.0,
    );

TextStyle white10bold() => const TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white12bold() => const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white14bold() => const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white16bold() => const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white18bold() => const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white20bold() => const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

TextStyle white10regular() => const TextStyle(
      fontSize: 10.0,
      color: Colors.white,
    );
TextStyle white12regular() => const TextStyle(
      fontSize: 12.0,
      color: Colors.white,
    );
TextStyle white14regular() => const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    );
TextStyle white16regular() => const TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    );
TextStyle white18regular() => const TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    );
TextStyle white20regular() => const TextStyle(
      fontSize: 20.0,
      color: Colors.white,
    );
