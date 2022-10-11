import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layouts/news/cubit/cubit.dart';
import 'package:news/layouts/news/cubit/states.dart';
import 'package:news/shared/components/components.dart';

class Science extends StatelessWidget {
  Science({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewsCubit.get(context);
          var list = NewsCubit.get(context).scienceArticlesList;
          return cubit.connectionState == false ?
          noInternetConnection(context,cubit.isDark ,Color(0xff0c201a),Colors.white,cubit.checkNetwork)
              :(list.isEmpty
              ?
          circularLoading(context)
              :
          Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    var element = list[index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          buildArticleItem(context,list[index]),
                          InkWell(
                            onTap: (){
                              cubit.insertData(
                                  title: element['title']!=null?element['title']:"Empty Title",
                                  imageUrl: element['urlToImage'],
                                  date: element['publishedAt']!=null?element['publishedAt']:"Empty Date",
                                  category: cubit.categoriesListInEnglish[cubit.caregoryCurrentIndex],
                                  url: element['url']!=null?element['url']:"Empty Url");
                              showNotify(context,"تـمت الإضافة إلى المحفوظات",cubit.isDark);
                            },
                            child: buildSaveSection(context),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context,index){
                    return  Divider(color: Colors.grey.withOpacity(.5),thickness: .5,height: 30,);
                  },
                  itemCount: list.length
              ),
            ],
          ));
        });
  }
}
