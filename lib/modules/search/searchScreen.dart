import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/search/cubit/cubit.dart';
import 'package:salla/modules/search/cubit/stats.dart';

import '../../models/search/searchModel.dart';
import '../../shared/app_cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchControlle = TextEditingController();
  GlobalKey globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStats>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: globalKey,
                child: Column(children: [
                  defaultFormField(
                    controller: searchControlle,
                    type: TextInputType.text,
                    lable: "Search",
                    prefx: Icons.search,
                    onSubmite: (value) {
                      SearchCubit.get(context).search(value);
                    },
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter Search text";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is SearchLoadingStats) LinearProgressIndicator(),
                  if (state is SearchSuccessStats)
                    Expanded(
                      child: ConditionalBuilder(
                        condition: state is SearchLoadingStats,
                        builder: (context) =>
                            Center(child: CircularProgressIndicator()),
                        fallback: (context) => ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return searachComponent(
                                  context,
                                  SearchCubit.get(context)
                                      .searchModel!
                                      .data!
                                      .data![index]);
                            },
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey,
                                ),
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .length),
                      ),
                    ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searachComponent(context, Product dataSearch) => Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: the_size_height(context) * .15,
          child: Row(
            children: [
              Stack(alignment: Alignment.bottomLeft, children: [
                Image(
                  image: NetworkImage('${dataSearch.image}'),
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
              ]),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataSearch.name!,
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
                          '${dataSearch.price}',
                          style: TextStyle(color: defaultColor),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopeCubit.get(context)
                                  .changeFavorites(dataSearch.id!);
                            },
                            icon: CircleAvatar(
                                backgroundColor: ShopeCubit.get(context)
                                        .favorits[dataSearch.id!]!
                                    ? defaultColor
                                    : Colors.grey,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 17,
                                  color: Colors.white,
                                ))),
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
