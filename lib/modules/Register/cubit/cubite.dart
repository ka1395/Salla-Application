import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/network/rempte/endPoint.dart';

import '../../../models/login/shopeLoginModel.dart';
import '../../../shared/app_cubit/cubit.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/rempte/dio.dart';
import 'states.dart';

class ShopRegisterCubit extends Cubit<ShopeRegisterStats> {
  ShopRegisterCubit() : super(ShopeRegisterInitialStats());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  IconData suffixIcon = Icons.visibility_rounded;

  bool isVisible = false;

  ShopeLoginModel? shopRegisterData;

  changePasswordVisibiliy() {
    isVisible = !isVisible;

    suffixIcon = isVisible ? Icons.visibility_off : Icons.visibility_rounded;
    emit(ShopeRegisterPasswordVisibiltyStats());
  }

  userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    BuildContext? context,
  }) {
    emit(ShopeRegisterLoadingStats());
    DioHelper.post(url: REGISTER, data: {
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
    }).then((value) {
      shopRegisterData = ShopeLoginModel.fromJson(value.data);
      token = shopRegisterData!.data!.token!;
      ShopeCubit.get(context).getUserData();
      print("this is login token ${token}");
      emit(ShopeRegisterSuccessStats(shopRegisterData!));
    }).catchError((error) {
      emit(ShopeRegisterErrorStats(error.toString()));
      print(error);
    });
  }
}
