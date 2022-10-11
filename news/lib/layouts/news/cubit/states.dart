abstract class NewsAppStates{}
class NewsAppInitialState extends NewsAppStates{}
class NewsAppBottomNavigationBarState extends NewsAppStates{}
class NewsAppChangeBottomNavigationBarIndexState extends NewsAppStates{}
class NewsAppChangeCategoryIndexState extends NewsAppStates{}
class NewsAppChangedropDownValueState extends NewsAppStates{}
class NewsAppScrollToTopOfScreenState extends NewsAppStates{}
class NewsAppScrollAtTheEndState extends NewsAppStates{}
class NewsAppNetworkConnectionState extends NewsAppStates{}
class NewsAppChangeAPIState extends NewsAppStates{}
class NewsAppChangeAPIManuallyState extends NewsAppStates{}


class NewsAppLoadBusinessState extends NewsAppStates{}
class NewsAppGetBusinessSuccessState extends NewsAppStates{}
class NewsAppGetBusinessErrorState extends NewsAppStates{
  String error;
  NewsAppGetBusinessErrorState(this.error);
}

class NewsAppLoadSportsState extends NewsAppStates{}
class NewsAppGetSportsSuccessState extends NewsAppStates{}
class NewsAppGetSportsErrorState extends NewsAppStates{
  String error;
  NewsAppGetSportsErrorState(this.error);
}

class NewsAppLoadHealthState extends NewsAppStates{}
class NewsAppGetHealthSuccessState extends NewsAppStates{}
class NewsAppGetHealthErrorState extends NewsAppStates{
  String error;
  NewsAppGetHealthErrorState(this.error);
}

class NewsAppLoadTechnologyState extends NewsAppStates{}
class NewsAppGetTechnologySuccessState extends NewsAppStates{}
class NewsAppGetTechnologyErrorState extends NewsAppStates{
  String error;
  NewsAppGetTechnologyErrorState(this.error);
}

class NewsAppLoadScienceState extends NewsAppStates{}
class NewsAppGetScienceSuccessState extends NewsAppStates{}
class NewsAppGetScienceErrorState extends NewsAppStates{
  String error;
  NewsAppGetScienceErrorState(this.error);
}

class NewsAppLoadEntertainmentState extends NewsAppStates{}
class NewsAppGetEntertainmentSuccessState extends NewsAppStates{}
class NewsAppGetEntertainmentErrorState extends NewsAppStates{
  String error;
  NewsAppGetEntertainmentErrorState(this.error);
}

class NewsAppLoadSearchState extends NewsAppStates{}
class NewsAppeEmptySearchListState extends NewsAppStates{}
class NewsAppGetSearchSuccessState extends NewsAppStates{}
class NewsAppGetSearchErrorState extends NewsAppStates{
  String error;
  NewsAppGetSearchErrorState(this.error);
}

class NewsAppChangeSwitchValue extends NewsAppStates{}
class NewsAppChangeModeThemeState extends NewsAppStates{}

class NewsAppCreateDatabaseLoadingState extends NewsAppStates{}
class NewsAppCreateDatabaseSuccessState extends NewsAppStates{}
class NewsAppCreateDatabaseErrorState extends NewsAppStates{
  String error;
  NewsAppCreateDatabaseErrorState(this.error);
}

class NewsAppGetDatabaseLoadingState extends NewsAppStates{}
class NewsAppGetDatabaseSuccessState extends NewsAppStates{}
class NewsAppGetDatabaseErrorState extends NewsAppStates{
  String error;
  NewsAppGetDatabaseErrorState(this.error);
}

class NewsAppDeleteFromDatabaseLoadingState extends NewsAppStates{}
class NewsAppDeleteFromDatabaseSuccessState extends NewsAppStates{}
class NewsAppDeleteFromDatabaseErrorState extends NewsAppStates{
  String error;
  NewsAppDeleteFromDatabaseErrorState(this.error);
}

class NewsAppInsertIntoDatabaseLoadingState extends NewsAppStates{}
class NewsAppInsertIntoDatabaseSuccessState extends NewsAppStates{}
class NewsAppInsertIntoDatabaseErrorState extends NewsAppStates{
  String error;
  NewsAppInsertIntoDatabaseErrorState(this.error);
}

class NewsAppSelectFromDatabaseLoadingState extends NewsAppStates{}
class NewsAppSelectFromDatabaseSuccessState extends NewsAppStates{}
class NewsAppSelectFromDatabaseErrorState extends NewsAppStates{
  String error;
  NewsAppSelectFromDatabaseErrorState(this.error);
}

class NewsAppFilteredSelectionDatabaseLoadingState extends NewsAppStates{}
class NewsAppFilteredSelectionDatabaseSuccessState extends NewsAppStates{}
class NewsAppFilteredSelectionDatabaseErrorState extends NewsAppStates{
  String error;
  NewsAppFilteredSelectionDatabaseErrorState(this.error);
}