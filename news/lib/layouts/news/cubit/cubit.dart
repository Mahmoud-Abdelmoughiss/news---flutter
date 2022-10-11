import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news/layouts/news/business/business.dart';
import 'package:news/layouts/news/cubit/states.dart';
import 'package:news/layouts/news/entertainment/entertainment.dart';
import 'package:news/layouts/news/health/health.dart';
import 'package:news/layouts/news/science/science.dart';
import 'package:news/layouts/news/sports/sports.dart';
import 'package:news/layouts/news/technology/technology.dart';
import 'package:news/modules/news/home/home.dart';
import 'package:news/modules/news/savings/savings.dart';
import 'package:news/modules/news/settings/settings.dart';
import 'package:news/shared/network/cache_helper.dart';
import 'package:news/shared/network/remote.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class NewsCubit extends Cubit<NewsAppStates>{
  NewsCubit():super(NewsAppInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);


  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.settings),label: "الضـــبـط",tooltip: "الضبط"),
    const BottomNavigationBarItem(icon: Icon(Icons.list),label: "الأخـبـــــار",tooltip: "الأخبار"),
    const BottomNavigationBarItem(icon: Icon(Icons.save_alt_outlined),label: "المحفـــوظـات",tooltip: "الحفوظات"),
  ];


  ///scroll up
  var listViewController = ScrollController();

  void scrollUp()async{
    ///first way
    // Delay to make sure the frames are rendered properly
    // await Future.delayed(const Duration(milliseconds: 300));
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   listViewController.animateTo(
    //       listViewController.position.minScrollExtent,
    //       duration: const Duration(milliseconds: 400),
    //       curve: Curves.fastOutSlowIn);
    // });

    ///second way
    final double start = 0;
    listViewController.animateTo(start, duration: Duration(seconds: 2), curve: Curves.easeInOut);
    ///third way
    // listViewController.jumpTo(start);
    emit(NewsAppScrollToTopOfScreenState());
  }
  // bool isAtEnd = false;
  // bool isAtTop = false;
  // addListenerToScrollController(){
  //   listViewController.addListener(() {
  //     isAtTop = listViewController.position.pixels == 0;
  //     isAtEnd = listViewController.position.pixels != 0;
  //   });
  //   emit(NewsAppScrollAtTheEndState());
  // }

  int bottomNavBarIndex = 1;
  List mainScreens = [
    Settings(),
    Home(),
    Savings(),
  ];
  changeBottomNavBarIndex(int index){
    bottomNavBarIndex = index;
    emit(NewsAppBottomNavigationBarState());
  }


  List<Widget> categoriesScreen = [
    Business(),
    Health(),
    Sports(),
    Technology(),
    Science(),
    Entertainment(),
  ];

  ///start horizontal ListView
  List<String> categoriesList = [
    'الأعـــمــال',
    'الصـــحـــة',
    'الـريــاضـة',
    'التكنولوجيا',
    'الـعــلــوم',
    'الـرفاهيــة'
  ];
  //used in inserting and filtered
  List<String> categoriesListInEnglish = [
    'Business',
    'Health',
    'Sports',
    'Technology',
    'Sciences',
    'Entertainments'
  ];
  String dropDownCurrentValue = 'الـــكــــل';
  List<String> dropDownListItems = [
    'الـــكــــل',
    'الأعـــمــال',
    'الصـــحـــة',
    'الـريــاضـة',
    'التكنولوجيا',
    'الـعــلــوم',
    'الـرفاهيــة'
  ];
  changedropDownValue(value){
    dropDownCurrentValue = value;
    int indexOfPressedElement = dropDownListItems.indexOf(value);
    if(indexOfPressedElement!=0)
    getFilteredData(category: categoriesListInEnglish[indexOfPressedElement-1]);
    else
      getAllData(database);
    emit(NewsAppChangedropDownValueState());
  }
  List<String> categoriesBgImage = [
    'assets/newsImages/business.jpg',
    'assets/newsImages/health.jpeg',
    'assets/newsImages/sports.jpg',
    'assets/newsImages/technology.jpeg',
    'assets/newsImages/science.jpg',
    'assets/newsImages/entertainment.jpg',
  ];
  int caregoryCurrentIndex = 0;
  onCategoryPressed(int index){
    caregoryCurrentIndex = index;
    emit(NewsAppChangeCategoryIndexState());
  }

  ///network state
  bool connectionState = false;
  checkNetwork()async{
    connectionState = await InternetConnectionChecker().hasConnection;
    if(connectionState){
      getBusinessArticles();
      getEntertainmentArticles();
      getHealthArticles();
      getScienceArticles();
      getSportsArticles();
      getTechnologyArticles();
    }
    emit(NewsAppNetworkConnectionState());
  }

  ///API key
   String apiKey = '55b8b2691a2e415ea8ab173cc7e94bda';
   String apiKeyPlaceholder = 'API Key No 5';
  List<String> apiKeysList = [
    'd6e9937c01d04b1d99a14aa9a0a39597',
    'f36dff8d466f425886e9b2564c6180fe',
    'deceed874ae74c96a3318925e3f407ee',
    '8963d4f913d44c988b2673fb8493a7e0',
    '55b8b2691a2e415ea8ab173cc7e94bda',
    'e8bbde41b73b4b0fae59f1d8c65173ef',
  ];
  List<String> apiKeysListPlaceholder = [
    'API Key No 1',
    'API Key No 2',
    'API Key No 3',
    'API Key No 4',
    'API Key No 5',
    'API Key No 6',
  ];
   changeApi(){
    int rand = Random().nextInt(apiKeysList.length-1);
    apiKey = apiKeysList[rand];
    apiKeyPlaceholder = apiKeysListPlaceholder[rand];
    emit(NewsAppChangeAPIState());
  }
  changeApiKeyManually(value){
     int index = apiKeysListPlaceholder.indexOf(value);
     apiKey = apiKeysList[index];
     apiKeyPlaceholder = apiKeysListPlaceholder[index];
     emit(NewsAppChangeAPIManuallyState());
  }

  ///business
  List businessArticlesList = [];
  getBusinessArticles(){
    Map<String, dynamic> query = {
      'apiKey': apiKey,
      "country":"eg",
      "category":"business",
    };
    String url = "v2/top-headlines";
    emit(NewsAppLoadBusinessState());
    if(businessArticlesList.isEmpty)
    {
      DioHelper.getData(url,query).then((value) {
        /// note : to access json data use : value.data
        businessArticlesList = value.data['articles'];
        emit(NewsAppGetBusinessSuccessState());
      }).catchError((error){
        emit(NewsAppGetBusinessErrorState(error.toString()));
      });
    }
  }

  ///health
  List healthArticlesList = [];
  getHealthArticles(){
    Map<String, dynamic> query = {
      'apiKey': apiKey,
      "country":"eg",
      "category":"health",
    };
    String url = "v2/top-headlines";
    emit(NewsAppLoadHealthState());
    if(healthArticlesList.isEmpty)
    {
      DioHelper.getData(url,query).then((value) {
        /// note : to access json data use : value.data
        healthArticlesList = value.data['articles'];
        emit(NewsAppGetHealthSuccessState());
      }).catchError((error){
        emit(NewsAppGetHealthErrorState(error.toString()));
      });
    }
  }

  ///Sports
  List sportsArticlesList = [];
  getSportsArticles(){
    Map<String, dynamic> query = {
      'apiKey': apiKey,
      "country":"eg",
      "category":"sports",
    };
    String url = "v2/top-headlines";
    emit(NewsAppLoadSportsState());
    if(sportsArticlesList.isEmpty)
    {
      DioHelper.getData(url,query).then((value) {
        /// note : to access json data use : value.data
        sportsArticlesList = value.data['articles'];
        emit(NewsAppGetSportsSuccessState());
      }).catchError((error){
        emit(NewsAppGetSportsErrorState(error.toString()));
      });
    }
  }

  ///Technology
  List technologyArticlesList = [];
  getTechnologyArticles(){
    Map<String, dynamic> query = {
      'apiKey': apiKey,
      "country":"eg",
      "category":"technology",
    };
    String url = "v2/top-headlines";
    emit(NewsAppLoadTechnologyState());
    if(technologyArticlesList.isEmpty)
    {
      DioHelper.getData(url,query).then((value) {
        /// note : to access json data use : value.data
        technologyArticlesList = value.data['articles'];
        emit(NewsAppGetTechnologySuccessState());
      }).catchError((error){
        emit(NewsAppGetTechnologyErrorState(error.toString()));
      });
    }
  }

  ///Science
  List scienceArticlesList = [];
  getScienceArticles(){
    Map<String, dynamic> query = {
      'apiKey': apiKey,
      "country":"eg",
      "category":"science",
    };
    String url = "v2/top-headlines";
    emit(NewsAppLoadScienceState());
    if(scienceArticlesList.isEmpty)
    {
      DioHelper.getData(url,query).then((value) {
        /// note : to access json data use : value.data
        scienceArticlesList = value.data['articles'];
        emit(NewsAppGetScienceSuccessState());
      }).catchError((error){
        emit(NewsAppGetScienceErrorState(error.toString()));
      });
    }
  }

  ///entertainment
  List entertainmentArticlesList = [];
  getEntertainmentArticles(){
    Map<String, dynamic> query = {
      'apiKey':'d6e9937c01d04b1d99a14aa9a0a39597',
      "country":"eg",
      "category":"entertainment",
    };
    String url = "v2/top-headlines";
    emit(NewsAppLoadEntertainmentState());
    if(entertainmentArticlesList.isEmpty)
    {
      DioHelper.getData(url,query).then((value) {
        /// note : to access json data use : value.data
        entertainmentArticlesList = value.data['articles'];
        emit(NewsAppGetEntertainmentSuccessState());
      }).catchError((error){
        emit(NewsAppGetEntertainmentErrorState(error.toString()));
      });
    }
  }

  ///search
  List searchList = [];
  ///empty list used to empty list when press search icon in home
  emptySearchList(){
    searchList = [];
    emit(NewsAppeEmptySearchListState());
  }
  getSearchArticles({@required String searchKeyword}){
    Map<String, dynamic> query = {
      'apiKey': apiKey,
      "q": searchKeyword,
      'language' : 'ar',
    };
    String url = "v2/everything";
    emit(NewsAppLoadSearchState());
      DioHelper.getData(url,query).then((value) {
        /// note : to access json data use : value.data
        searchList = value.data['articles'];
        emit(NewsAppGetSearchSuccessState());
      }).catchError((error){
        emit(NewsAppGetSearchErrorState(error.toString()));
      });

  }

  /// settings section
   bool isDark = false ;
   changeSwitchValue(bool value){
    isDark = value;
    CacheHelper.setBoolean(key: "isDark", value: isDark).then((value){
      print("=====================$value===================================");
    emit(NewsAppChangeSwitchValue());
    });
  }
  //
  bool darkMode = false;
  bool getThemeMode(){
    // bool? mode ;
    darkMode = CacheHelper.getBoolean(key: "isDark");
    if(CacheHelper.getBoolean(key: "isDark")==null){
      darkMode = false;
    }else{
      darkMode = CacheHelper.getBoolean(key: "isDark");
    }
    isDark= darkMode;
    emit(NewsAppChangeModeThemeState());
  }


  ///sqflite database
  ///must declare database with Database not var
  var savingsItems = [];
  static Database database ;

  createDatabase()async{
    var databasePath=await getDatabasesPath();
    var path = join(databasePath,'news_db.db');
     openDatabase(
        path,
        version: 1,
        onCreate: (database,version)async{
          await database.execute
            ("create table news(id integer primary key,title text,date text ,image_url text,category text,url text)").then((value){
              print("________________________table created successfully______________________________________");
          }).catchError((error){
            print("________________________table creating error occurs______________________________________");
          });
        },
        onOpen: (database){
          getAllData(database);
        }
        ).then((value){
          database = value ;
          print("_____________________database opened ");
          emit(NewsAppCreateDatabaseSuccessState());
    }).catchError((error){
      emit(NewsAppCreateDatabaseErrorState(error.toString()));
    });
  }
  insertData({
    @required String title,
    @required String imageUrl,
    @required String date,
    @required String category,
    @required String url,
          })async{
               database.transaction((transaction){
                return transaction.rawInsert("insert into news(title,date,category,image_url,url) values (?,?,?,?,?)",['$title','$date','$category','$imageUrl','$url']).
                then((value){
                  emit(NewsAppInsertIntoDatabaseSuccessState());
                  getAllData(database);
                }).catchError((error){
                  emit(NewsAppInsertIntoDatabaseErrorState(error.toString()));
                });
          });
        }

    getAllData(database){
      savingsItems = [];
      NewsAppSelectFromDatabaseLoadingState();
      return database.rawQuery('select * from news').then((value) {
        savingsItems = value;
        emit(NewsAppSelectFromDatabaseSuccessState());
      }).catchError((error){
        emit(NewsAppSelectFromDatabaseErrorState(error.toString()));
      });
    }

    getFilteredData({@required String category}){
    savingsItems = [];
      NewsAppFilteredSelectionDatabaseLoadingState();
      return database.rawQuery('select * from news where category =  ?',['$category']).then((value) {
        value.forEach((element) {
          if(element['category']==category){
            savingsItems.add(element);
          }
        });
        emit(NewsAppFilteredSelectionDatabaseSuccessState());
      }).catchError((error){
        emit(NewsAppFilteredSelectionDatabaseErrorState(error.toString()));
      });
    }

    deleteData({@required int id}){
      database.rawDelete("delete from news where id = ?",[id]).then((value){
        getAllData(database);
        emit(NewsAppDeleteFromDatabaseSuccessState());
      }).catchError((error){
        emit(NewsAppDeleteFromDatabaseErrorState(error.toString()));
      });
    }

}