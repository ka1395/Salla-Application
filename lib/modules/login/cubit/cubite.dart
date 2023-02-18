import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/login/cubit/states.dart';

import '../../../models/login/shopeLoginModel.dart';
import '../../../shared/app_cubit/cubit.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/rempte/dio.dart';
import '../../../shared/network/rempte/endPoint.dart';

class ShopLoginCubit extends Cubit<ShopeLoginStats> {
  ShopLoginCubit() : super(ShopeLoginInitialStats());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_rounded;

  bool isVisible = false;

  ShopeLoginModel? shopLoginData;

  changePasswordVisibiliy() {
    print(isVisible);
    isVisible = !isVisible;

    suffixIcon = isVisible ? Icons.visibility_off : Icons.visibility_rounded;
    emit(ShopeLoginPasswordVisibiltyStats());
  }

  userLogin({
    required String email,
    required String password,
    BuildContext? context,
  }) {
    emit(ShopeLoginLoadingStats());
    DioHelper.post(url: LOGIN, data: {
      "email": email,
      "password": password,
    }).then((value) {
      shopLoginData = ShopeLoginModel.fromJson(value.data);
      token = shopLoginData!.data!.token!;
      ShopeCubit.get(context).getUserData();
      print("this is login token ${token}");
      emit(ShopeLoginSuccessStats(shopLoginData!));
    }).catchError((error) {
      emit(ShopeLoginErrorStats(error.toString()));
      print(error);
    });
    ;
  }
}
