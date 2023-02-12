import 'package:abdullaa/moduls/shopApp/search/SearchState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/ShopModelss/searchModel.dart';
import '../../../shared/compounant/constant.dart';
import '../../../shared/network/dio_helper.dart';
import '../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(initialState) : super(ShopSearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void getSearch(String text) {
    emit(ShopSearchLoadingState());
    Dio_Helper.postData(url: search, token: token, data: {'text': text})
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopSearchErrorState(error));
    });
  }
}
