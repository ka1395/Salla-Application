import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/Register/cubit/cubite.dart';
import 'package:salla/modules/Register/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cashmemory.dart';
import '../../shared/styles/styles.dart';
import '../homeLayout/shopeHomeLayoutScreen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var globalkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopeRegisterStats>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          if (cubit.shopRegisterData != null) {
            if (state is! ShopeRegisterLoadingStats) if (cubit
                .shopRegisterData!.status!) {
              showToast(
                  text: cubit.shopRegisterData!.message!,
                  color: ToastColors.SUCCESS);
              CashHelper.saveData(
                      key: "token", value: cubit.shopRegisterData!.data!.token)
                  .then((value) {
                if (value) {
                  navigateAndFinish(context, ShopeHomeLayoutScreen());
                }
              });
            } else {
              showToast(
                  text: cubit.shopRegisterData!.message!,
                  color: ToastColors.ERROR);
            }
          }

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: globalkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("REGISTER",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: the_size_height(context) * .03,
                        ),
                        Text("Register now to browse our hot offers",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                        SizedBox(
                          height: the_size_height(context) * .03,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          lable: "Name",
                          prefx: Icons.person,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter Name";
                            }
                          },
                        ),
                        SizedBox(
                          height: the_size_height(context) * .02,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          lable: "Phone",
                          prefx: Icons.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter phone ";
                            }
                          },
                        ),
                        SizedBox(
                          height: the_size_height(context) * .02,
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
                          suffix: ShopRegisterCubit.get(context).suffixIcon,
                          isPassword: ShopRegisterCubit.get(context).isVisible,
                          onSubmite: (p0) {
                            // ShopRegisterCubit.get(context).userRegister(
                            //     email: emailController.text,
                            //     password: passwordController.text);
                          },
                          suffixPassword: () {
                            ShopRegisterCubit.get(context)
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
                          condition: state is ShopeRegisterLoadingStats,
                          builder: (context) =>
                              Center(child: CircularProgressIndicator()),
                          fallback: (context) => defaultButton(
                              function: () {
                                if (globalkey.currentState!.validate()) {
                                  print("buttom register");
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      context: context);
                                }
                              },
                              text: "Register"),
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
