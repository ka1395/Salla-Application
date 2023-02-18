import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/favorites/getFavoritesModel.dart';
import '../../shared/app_cubit/cubit.dart';
import '../../shared/app_cubit/stats.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit, ShopeStats>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopeCubit.get(context);
        return cubit.getFavoritiesModel!.data==null|| cubit.getFavoritiesModel!.data!.data!.length == 0 
            ? Center(
                child: Image(
                  image: AssetImage("assets/images/notfav.jpg"),
                ),
              )
            : ConditionalBuilder(
                condition: state is ShopeGetFavoritesLoadingStats,
                builder: (context) =>
                    Center(child: CircularProgressIndicator()),
                fallback: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FavoriteComponent(context,
                          cubit.getFavoritiesModel!.data!.data![index]);
                    },
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                        ),
                    itemCount: cubit.getFavoritiesModel!.data!.data!.length),
              );
     
      },
    );
  }

  Widget FavoriteComponent(context, Data dataFavorits) => Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: the_size_height(context) * .15,
          child: Row(
            children: [
              Stack(alignment: Alignment.bottomLeft, children: [
                Image(
                  image: NetworkImage('${dataFavorits.product!.image}'),
                  height: the_size_height(context) * .15,
                  width: the_size_width(context) * .3,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                      //Image.asset("assets/images/notfound.jpg");
                    }
                    return Image.asset(
                      "assets/images/notfound.jpg",
                      height: the_size_height(context) * .15,
                      width: the_size_width(context) * .3,
                    );
                  },
                ),
                if (dataFavorits.product!.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
              ]),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataFavorits.product!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${dataFavorits.product!.price}',
                          style: TextStyle(color: defaultColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (dataFavorits.product!.discount != 0)
                          Text(
                            '${dataFavorits.product!.oldPrice}',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopeCubit.get(context)
                                  .changeFavorites(dataFavorits.product!.id!);
                            },
                            icon: CircleAvatar(
                                backgroundColor: ShopeCubit.get(context)
                                        .favorits[dataFavorits.product!.id]!
                                    ? defaultColor
                                    : Colors.grey,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 17,
                                  color: Colors.white,
                                )))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

}
