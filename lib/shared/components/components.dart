import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../app_cubit/cubit.dart';

import '../styles/colors.dart';
import '../styles/icon_broken.dart';
import '../styles/styles.dart';

class LanguageModel {
  final String language;
  final String code;

  LanguageModel({
    required this.language,
    required this.code,
  });
}

List<LanguageModel> languageList = [
  LanguageModel(
    language: 'English',
    code: 'en',
  ),
  LanguageModel(
    language: 'العربية',
    code: 'ar',
  ),
];

// Widget languageItem(
//   LanguageModel model, {
//   context,
//   index,
// }) =>
//     InkWell(
//       onTap: () {
//         AppCubit.get(context).changeSelectedLanguage(index);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 model.language,
//               ),
//             ),
//             if (AppCubit.get(context).selectedLanguage[index])
//               Icon(
//                 IconBroken.Arrow___Right_Circle,
//               ),
//           ],
//         ),
//       ),
//     );

Widget defaultSeparator() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

Widget defaultButton({
  required VoidCallback function,
  required String text,
}) =>
    Container(
      height: 55.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(
          3.0,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: white14bold(),
        ),
      ),
    );

void showToast({
  required String text,
  required ToastColors color,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: setToastColor(color),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }

  return c;
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

class bordingitem {
  final String image;
  final String title;
  final String body;

  bordingitem({required this.image, required this.title, required this.body});
}

Widget OnBoardComponent(BuildContext context, bordingitem page) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            page.image,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: the_size_height(context, appbar: true) * .02,
        ),
        Text(
          page.title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Jannah"),
        ),
        SizedBox(
          height: the_size_height(context, appbar: true) * .05,
        ),
        Text(
            textAlign: TextAlign.center,
            page.body,
            style: TextStyle(
              fontSize: 16,
            )),
        SizedBox(
          height: the_size_height(context, appbar: true) * .03,
        ),
      ],
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmite,
  Function(String)? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  validate,
  String? lable,
  IconData? prefx,
  IconData? suffix,
  VoidCallback? suffixPassword,
  Color? fillcolor,
  bool? Isfilled,
  double borderradius = 4.0,
  String hint = " ",
  Color? iconColor,
  Color? textColor,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onSubmite,
      validator: validate,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: textColor),
          fillColor: fillcolor,
          filled: Isfilled,
          labelText: lable,
          prefixIcon: prefx == null
              ? null
              : Icon(
                  prefx,
                  color: iconColor,
                ),
          suffixIcon: IconButton(
            onPressed: suffixPassword,
            icon: Icon(
              suffix,
              color: iconColor,
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderradius)))),
    );
