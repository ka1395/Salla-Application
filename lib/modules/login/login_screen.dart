import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/Register/registerScreen.dart';
import 'package:salla/modules/homeLayout/shopeHomeLayoutScreen.dart';
import 'package:salla/modules/login/cubit/cubite.dart';
import 'package:salla/modules/login/cubit/states.dart';

import 'package:salla/shared/network/local/cashmemory.dart';
import 'package:salla/shared/styles/styles.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var globalkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopeLoginStats>(
        listener: (context, state) {
          if (state is! ShopeLoginLoadingStats) if (ShopLoginCubit.get(context)
              .shopLoginData!
              .status!) {
            showToast(
                text: ShopLoginCubit.get(context).shopLoginData!.message!,
                color: ToastColors.SUCCESS);
            CashHelper.saveData(
                    key: "token",
                    value:
                        ShopLoginCubit.get(context).shopLoginData!.data!.token)
                .then((value) {
              if (value) {
                navigateAndFinish(context, ShopeHomeLayoutScreen());
              }
            });
          } else {
            showToast(
                text: ShopLoginCubit.get(context).shopLoginData!.message!,
                color: ToastColors.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                width: the_size_width(context) * .9,
                child: SingleChildScrollView(
                  child: Form(
                    key: globalkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: the_size_height(context) * .03,
                        ),
                        Text("Login now to browse our hot offers",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                        SizedBox(
                          height: the_size_height(context) * .03,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          lable: "Email Address",
                          prefx: Icons.email_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter email adress";
                            }
                          },
                        ),
                        SizedBox(
                          height: the_size_height(context) * .02,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          lable: "Password",
                          prefx: Icons.lock_outline_sharp,
                          suffix: ShopLoginCubit.get(context).suffixIcon,
                          isPassword: ShopLoginCubit.get(context).isVisible,
                          onSubmite: (p0) {
                            ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          },
                          suffixPassword: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibiliy();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            }
                          },
                        ),
                        SizedBox(
                          height: the_size_height(context) * .02,
                        ),
                        ConditionalBuilder(
                          condition: state is ShopeLoginLoadingStats,
                          builder: (context) =>
                              Center(child: CircularProgressIndicator()),
                          fallback: (context) => defaultButton(
                              function: () {
                                if (globalkey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context);
                                }
                              },
                              text: "LOGIN"),
                        ),
                        SizedBox(
                          height: the_size_height(context) * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? "),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: Text("REGISTER"))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
