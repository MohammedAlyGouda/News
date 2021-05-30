import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_one_flutter_app/layout/news_app/cubit/states.dart';
import 'package:new_one_flutter_app/modules/news_app/business/busniess_screen.dart';
import 'package:new_one_flutter_app/modules/news_app/science/science_screen.dart';
import 'package:new_one_flutter_app/modules/news_app/sports/sports_screen.dart';
import 'package:new_one_flutter_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      qul: {
        "country": "eg",
        "category": "business",
        "apiKey": "4f6ab28dfb524f028583131de6e79d74",
      },
    ).then((value) {
      print(value.toString());
      business = value.data['articles'];
      emit(NewsGetDataBusinessSuccessState());
    }).catchError(
      (e) {
        emit(NewsGetDataBusinessErrorState(e.toString()));
        print(e.toString());
      },
    );
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      qul: {
        "country": "eg",
        "category": "sports",
        "apiKey": "4f6ab28dfb524f028583131de6e79d74",
      },
    ).then((value) {
      print(value.toString());
      sports = value.data['articles'];
      emit(NewsGetDataSportsSuccessState());
    }).catchError(
      (e) {
        emit(NewsGetDataSportsErrorState(e.toString()));
        print(e.toString());
      },
    );
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      qul: {
        "country": "eg",
        "category": "science",
        "apiKey": "4f6ab28dfb524f028583131de6e79d74",
      },
    ).then((value) {
      print(value.toString());
      science = value.data['articles'];
      emit(NewsGetDataScienceSuccessState());
    }).catchError(
      (e) {
        emit(NewsGetDataScienceErrorState(e.toString()));
        print(e.toString());
      },
    );
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsScienceLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      qul: {
        "q": "$value",
        "apiKey": "4f6ab28dfb524f028583131de6e79d74",
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetDataSearchSuccessState());
    }).catchError(
      (e) {
        emit(NewsGetDataSearchErrorState(e.toString()));
        print(e.toString());
      },
    );
  }

  // bool isDark = true;
  //
  // void changeAppModeFromDarkToLight() {
  //   isDark = !isDark;
  //   emit(NewsChangeModeState());
  // }
}
//bool isDark = true;
//
//   void changeAppModeFromDarkToLight() {
//     isDark = !isDark;
//     emit(AppChangeModeState());
//   }
