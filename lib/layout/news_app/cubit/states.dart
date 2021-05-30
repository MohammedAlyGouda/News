abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsBusinessLoadingState extends NewsStates {}

class NewsGetDataBusinessSuccessState extends NewsStates {}

class NewsGetDataBusinessErrorState extends NewsStates {
  final String error;

  NewsGetDataBusinessErrorState(this.error);
}

class NewsSportsLoadingState extends NewsStates {}

class NewsGetDataSportsSuccessState extends NewsStates {}

class NewsGetDataSportsErrorState extends NewsStates {
  final String error;

  NewsGetDataSportsErrorState(this.error);
}

class NewsScienceLoadingState extends NewsStates {}

class NewsGetDataScienceSuccessState extends NewsStates {}

class NewsGetDataScienceErrorState extends NewsStates {
  final String error;

  NewsGetDataScienceErrorState(this.error);
}

class NewsSearchLoadingState extends NewsStates {}

class NewsGetDataSearchSuccessState extends NewsStates {}

class NewsGetDataSearchErrorState extends NewsStates {
  final String error;

  NewsGetDataSearchErrorState(this.error);
}

class NewsChangeModeState extends NewsStates {}
