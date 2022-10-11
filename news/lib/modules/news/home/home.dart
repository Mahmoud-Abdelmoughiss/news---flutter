import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layouts/news/cubit/cubit.dart';
import 'package:news/layouts/news/cubit/states.dart';
import 'package:news/modules/news/search/search.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/network/remote.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsAppStates>(
        listener: (BuildContext context,NewsAppStates states){},
        builder: (BuildContext context,NewsAppStates states){
          var cubit = NewsCubit.get(context);
          var categoriesList = cubit.categoriesList;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text("أخبـــــــــــار  ${cubit.categoriesList[cubit.caregoryCurrentIndex]}"),
                actions: [
                  IconButton(
                      onPressed: (){
                    cubit.emptySearchList();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search()));
                  }, icon: Icon(Icons.search))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: categoriesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                cubit.onCategoryPressed(index);
                              },
                              child: BuildCategoriesItem(
                                  context: context,
                                  image: cubit.categoriesBgImage[index],
                                  category: categoriesList[index]),
                          );
                          },
                        ),
                      ),
                      const SizedBox(height: 10,),
                      cubit.categoriesScreen[cubit.caregoryCurrentIndex],
                    ],
                  ),
                ),
              ) ,

            ),
          );
        },
      );
  }
}
