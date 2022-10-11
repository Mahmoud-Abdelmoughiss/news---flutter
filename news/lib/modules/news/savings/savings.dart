import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layouts/news/cubit/cubit.dart';
import 'package:news/layouts/news/cubit/states.dart';
import 'package:news/shared/components/components.dart';

class Savings extends StatelessWidget {
  const Savings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewsCubit.get(context);
          var list = NewsCubit.get(context).savingsItems;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                // titleSpacing: MediaQuery.of(context).size.width/3*2,
                toolbarHeight: 120,
                centerTitle: true,
                title: Container(
                  child: Column(
                    children: [
                      Text("المحفوظات"),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color:cubit.isDark ? Colors.white: Color(0xff0c201a), )
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: cubit.isDark ?  Color(0xff0c201a):Colors.white,
                              filled: true,
                              hintText: "فــلتـر بالـنــوع",
                              hintStyle: TextStyle(
                                color: cubit.isDark ?  Colors.white:Color(0xff0c201a),
                              ),
                            ),
                            onChanged: (value){
                              cubit.changedropDownValue(value);
                            },
                            items: cubit.dropDownListItems.map((e){
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(e,style: TextStyle(
                                    color: Colors.deepOrange ,
                                  ),
                                    textAlign: TextAlign.start,
                                  )
                              );
                            }).toList(),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              body: list.isEmpty
                  ?
              EmptyList(context,"لا تـوجــد عناصر محفــوظة  ")
                  :
              ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  itemBuilder: (context,index){
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          buildArticleItem22(context,list[index]),
                          InkWell(
                            onTap: (){
                              cubit.deleteData(id: list[index]['id']);
                              showNotify(context,"تـمت عملية الحذف بنجــاح",cubit.isDark);
                            },
                            child: buildSaveSection(context,optionText: "حـذف مـن المحفوظــات",iconData: Icons.delete),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context,index){
                    return  Divider(color: Colors.grey.withOpacity(.5),thickness: .5,height: 30,);
                  },
                  itemCount: list.length
              )
            ),
          );
        });
  }
}
