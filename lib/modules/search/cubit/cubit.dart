import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/search/searchModel.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/rempte/dio.dart';
import 'package:salla/shared/network/rempte/endPoint.dart';

import 'stats.dart';

class SearchCubit extends Cubit<SearchStats> {
  SearchCubit() : super(SearchInitialStats());
 static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  search(String text) {
    emit(SearchLoadingStats());
    DioHelper.post(
            url: SEARCH,
            data: {
              'text': text,
            },
            token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.status);
      emit(SearchSuccessStats());
    }).catchError((Error) {
      print(Error);
      emit(SearchErrorStats(Error));
    });
  }
}
