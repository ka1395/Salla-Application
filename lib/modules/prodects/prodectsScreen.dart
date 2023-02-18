import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/categories/CategoriesModel.dart';
import 'package:salla/models/shope/homeModel.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/stats.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/styles.dart';

class prodectsScreen extends StatelessWidget {
  const prodectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit, ShopeStats>(
      listener: (context, state) {
        if (state is ShopeFavoritesSucssesChangeStats) {
          if (!state.FavoritesModel.status) {
            showToast(
                text: state.FavoritesModel.message, color: ToastColors.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubite = ShopeCubit.get(context);
        return ConditionalBuilder(
          condition: cubite.homeModel != null && cubite.categoriesModel != null,
          builder: (context) =>
              prodectBuilder(cubite.homeModel, cubite.categoriesModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget prodectBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data!.banners
                    .map((e) => Image(
                          image: NetworkImage("${e.image}"),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                              //Image.asset("assets/images/notfound.jpg");
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: the_size_height(context) * .25,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  Container(
                    height: the_size_height(context) * .15,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => categories(context,
                            categoriesModel.data!.dataCategories[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        itemCount:
                            categoriesModel!.data!.dataCategories.length),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "New Prodects",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1 / 1.71,
                  children: List.generate(
                      model.data!.products.length,
                      (index) =>
                          griptBuilder(model.data!.products[index], context))),
            ),
          ],
        ),
      );

  Widget griptBuilder(ProductDataModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: the_size_height(context) * .25,
                width: double.infinity,
                  loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                              //Image.asset("assets/images/notfound.jpg");
                            }
                            return Image.asset("assets/images/notfound.jpg", height: the_size_height(context) * .25,
                width: double.infinity,);
                           
                          },
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )
            ]),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.3,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(color: defaultColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.old_price}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopeCubit.get(context).changeFavorites(model.id!);
                          },
                          icon: CircleAvatar(
                              backgroundColor:
                                  ShopeCubit.get(context).favorits[model.id]!
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
      );

  Widget categories(context, DataModel datanodel) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            height: the_size_height(context) * .15,
            width: the_size_width(context) * .25,
            fit: BoxFit.cover,
            image: NetworkImage("${datanodel.image}",
            
            
            
            ),
              loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                              //Image.asset("assets/images/notfound.jpg");
                            }
                            return Image.asset("assets/images/notfound.jpg",
                            height: the_size_height(context) * .15,
            width: the_size_width(context) * .25,
                
                );
                           
                          },
          ),
          Container(
            width: the_size_width(context) * .25,
            color: Colors.black.withOpacity(.8),
            child: Text(
              "${datanodel.name}",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
}
