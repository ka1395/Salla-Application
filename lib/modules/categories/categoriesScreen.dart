import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/stats.dart';
import 'package:salla/shared/styles/colors.dart';

import '../../models/categories/CategoriesModel.dart';
import '../../shared/styles/styles.dart';

class CateforiesScreen extends StatelessWidget {
  const CateforiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit, ShopeStats>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopeCubit.get(context);
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => categories(
                context, cubit.categoriesModel!.data!.dataCategories[index]),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
            itemCount: cubit.categoriesModel!.data!.dataCategories.length);
      },
    );
  
  }

  Widget categories(context, DataModel dataModel) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage("${dataModel.image}"),
              height: the_size_height(context) * .2,
              width: the_size_width(context) * .3,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "${dataModel.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: defaultColor,
            ),
          ],
        ),
      );
}
