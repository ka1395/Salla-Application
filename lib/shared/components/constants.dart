// import 'package:flutter/services.dart';
// import 'package:salla/shared/app_cubit/cubit.dart';
// import 'package:salla/shared/di/di.dart';
// import 'package:salla/shared/language/app_language_model.dart';
// import 'package:salla/shared/network/local/cache_helper.dart';

// AppLanguageModel appLang(context) => AppCubit.get(context).languageModel;

// String appLanguage = '';

// String userToken = '';

// Future<String> getAppLanguage() async
// {
//   return await di<CacheHelper>().get('appLang');
// }

// Future<String> getUserToken() async
// {
//   return await di<CacheHelper>().get('userToken');
// }

// Future<bool> setAppLanguageToShared(String code) async
// {
//   appLanguage = code;
//   return await di<CacheHelper>().put('appLang', code);
// }

// Future<String> getTranslationFile(String appLanguage) async
// {
//   return await rootBundle
//       .loadString('assets/translation/${appLanguage ?? 'en'}.json');
// }

// void printFullText(String text)
// {
//   final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
//   pattern.allMatches(text).forEach((match) => print(match.group(0)));
// }

import '../network/local/cashmemory.dart';
import 'components.dart';

//  void logOut(context) {
//     CashHelper.removeData(key: "token").then((value) {
//       print("this remove login ${CashHelper.getData(key: "token")}");
//       navigateAndFinish(context, LoginScreen());
//     });
//   }

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}

String token='';
