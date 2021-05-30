import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_one_flutter_app/models/shop/search_model.dart';
import 'package:new_one_flutter_app/shared/components/constants.dart';
import 'package:new_one_flutter_app/shared/network/end_point.dart';
import 'package:new_one_flutter_app/shared/network/remote/dio_helper.dart';

import 'states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
