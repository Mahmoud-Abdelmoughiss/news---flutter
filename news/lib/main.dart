import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layouts/news/cubit/cubit.dart';
import 'package:news/layouts/news/cubit/states.dart';
import 'package:news/modules/news/landing_screen/landing_screen.dart';
import 'package:news/modules/news/mainScreen/main_screen.dart';
import 'package:news/shared/network/cache_helper.dart';
import 'package:news/shared/network/remote.dart';
import 'package:news/test.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  NewsApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>NewsCubit()..changeApi()..checkNetwork()..getThemeMode()..createDatabase()..getBusinessArticles()..getEntertainmentArticles()..getHealthArticles()..getScienceArticles()..getSportsArticles()..getTechnologyArticles(),
      child: BlocConsumer<NewsCubit,NewsAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewsCubit.get(context);
          return MaterialApp(
            color: Colors.deepOrange,
            title: "الأخبــار",
            debugShowCheckedModeBanner: false,
            home: Directionality(
                textDirection: TextDirection.rtl,
                child: LandingScreen()
            ),
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
                fontFamily:  "Kufam",
                scaffoldBackgroundColor: Colors.white,
                iconTheme:const IconThemeData(
                  color: Colors.deepOrange,
                ),
                textTheme: const TextTheme(
                  ///headline 2 : represent text in Categories horizontal list view
                    headline2:  TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    /// save articale statement
                    headline3:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepOrange,
                    ),
                    /// artical title
                    subtitle1: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                    /// artical published date
                    subtitle2:  TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    caption:TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    )
                ),
                appBarTheme: const AppBarTheme(
                  /// to change status bar color use systemOverlayStyle in AppBar
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontFamily: "Kufam"
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.deepOrange,
                    )
                ),
                bottomNavigationBarTheme:const BottomNavigationBarThemeData(
                    elevation: 30,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.black54
                )
            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                fontFamily:  "Kufam",
                scaffoldBackgroundColor:const Color(0xff0c201a),
                iconTheme:const IconThemeData(
                  color: Colors.deepOrange,
                ),
                textTheme: const TextTheme(
                  ///headline 2 : represent text in Categories horizontal list view
                    headline2:  TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    /// save articale statement
                    headline3:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepOrange,
                    ),
                    /// artical title
                    subtitle1: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                    /// artical published date
                    subtitle2:  TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),

                    caption:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    )
                ),
                appBarTheme: const AppBarTheme(
                  /// to change status bar color use systemOverlayStyle in AppBar
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color(0xff0c201a),
                      // statusBarColor: Color(0xff0c0f1a),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: Color(0xff0c201a),
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Kufam"
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    )
                ),
                bottomNavigationBarTheme:const BottomNavigationBarThemeData(
                    elevation: 100,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    backgroundColor: Color(0xff0c201a)
                )
            ),
            themeMode: CacheHelper.getBoolean(key: "isDark")!=null?
            ((CacheHelper.getBoolean(key: "isDark")==true)?ThemeMode.dark:ThemeMode.light)
                :
            ThemeMode.light,
            //cubit.isDark?ThemeMode.dark:ThemeMode.light,
          );
        },
      ),
    );
  }
}

