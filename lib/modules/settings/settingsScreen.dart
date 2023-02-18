import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/stats.dart';

import '../../shared/components/components.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    var globalkey = GlobalKey<FormState>();
    return BlocConsumer<ShopeCubit, ShopeStats>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopeCubit.get(context);
        nameController.text = cubit.userData!.data!.name!;
        phoneController.text = cubit.userData!.data!.phone!;
        emailController.text = cubit.userData!.data!.email!;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: globalkey,
            child: Column(
              children: [
                if (state is ShopePutUserDataLoadingStats)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  lable: "Name",
                  prefx: Icons.person,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter Your Name";
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  lable: "Email Adress",
                  prefx: Icons.email,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter Email Adress";
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  lable: "Phone",
                  prefx: Icons.email,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter Your Phone";
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                defaultButton(
                    function: () {
                      if (globalkey.currentState!.validate()) {
                        cubit.putUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }
                    },
                    text: "UPDATE"),
                SizedBox(
                  height: 15,
                ),
                defaultButton(
                    function: () {
                      if (globalkey.currentState!.validate()) {
                        cubit.logOut(context);
                      }
                    },
                    text: "LOGOUT"),
              ],
            ),
          ),
        );
      },
    );
  }
}
