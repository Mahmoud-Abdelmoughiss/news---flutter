import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layouts/news/cubit/cubit.dart';
import 'package:news/layouts/news/cubit/states.dart';
import 'package:news/shared/components/components.dart';

class Search extends StatelessWidget {
   Search({Key key}) : super(key: key);
  TextEditingController searchValue =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var list = NewsCubit.get(context).searchList;
          var cubit = NewsCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                // leadingWidth: 10,
                title: Column(
                  children: [
                    // Text("الـبحــــــــــث"),
                    // SizedBox(height: 20,),
                    Row(
                      children: [
                        ExkeyboardTypepanded(
                          child: TextFormField(
                            onFieldSubmitted: (value){
                              cubit.getSearchArticles(searchKeyword: value);
                              if(value.length > 0) {
                                String shortKeyword = value.length > 15 ? value
                                    .substring(0, 15) : value + "...";
                                showNotify(
                                    context, "جارى البحث عن : $shortKeyword",
                                    cubit.isDark,position: 1);
                              }
                            },
                            textInputAction: TextInputAction.go,
                            controller: searchValue,
                            textDirection: TextDirection.rtl,
                            decoration:  InputDecoration(
                              border:const OutlineInputBorder(),
                              enabledBorder:const  OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  )
                              ),
                              labelStyle: Theme.of(context).textTheme.caption,
                              // prefixIcon: Icon(Icons.search,color: cubit.isDark?Colors.white:Colors.black87,),
                              labelText: "ابــحث هــنــــــا",
                            ),
                            keyboardType: TextInputType.text,
                            // onChanged: (value){
                            //   cubit.getSearchArticles(searchKeyword: value);
                            // },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search,color: cubit.isDark?Colors.white:Colors.black87,),
                          onPressed: (){
                            cubit.getSearchArticles(searchKeyword: searchValue.text);
                            String value = searchValue.text;
                            if(value.length > 0) {
                              String shortKeyword = value.length > 15 ? value
                                  .substring(0, 15) : value + "...";
                              showNotify(context, "جارى البحث عن $shortKeyword",
                                  cubit.isDark,position: 1);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                toolbarHeight: 110,
              ),
              body:
              cubit.connectionState==false?Center(child: noInternetConnection(context,cubit.isDark ,Color(0xff0c201a),Colors.white,cubit.checkNetwork)):
              list.isEmpty
                ?
              EmptyList(context,"ابــــحث هنـــا")
                :
              ListView.separated(
                controller: cubit.listViewController,
                padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    var element = list[index];
                    return Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
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
                    return  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: Divider(color: Colors.grey,thickness: .7,));
                  },
                  itemCount: list.length
              ),
              floatingActionButton: list.length>=4?FloatingActionButton(
                mini: true,
                child: Icon(Icons.keyboard_arrow_up_outlined),
                onPressed: (){
                  cubit.scrollUp();
                },
              ):Container(),
            ),
          );
        });
  }
}
