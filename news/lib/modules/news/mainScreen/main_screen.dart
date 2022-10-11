import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layouts/news/cubit/cubit.dart';
import 'package:news/layouts/news/cubit/states.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsAppStates>(builder: (context,state){
      var cubit = NewsCubit.get(context);
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: cubit.mainScreens[cubit.bottomNavBarIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavBarItems,
            currentIndex: cubit.bottomNavBarIndex,
            onTap: (index){
              cubit.changeBottomNavBarIndex(index);
            },
          ),
        ),
      );
    }, listener: (context,state){});
  }
}
