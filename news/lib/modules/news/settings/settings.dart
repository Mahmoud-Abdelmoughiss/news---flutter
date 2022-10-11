import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layouts/news/cubit/cubit.dart';
import 'package:news/layouts/news/cubit/states.dart';
import 'package:news/shared/components/components.dart';
class Settings extends StatelessWidget {
  var searchValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("الــضـبـــــط"),
              leading: Icon(Icons.settings),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    child: SwitchListTile(
                      value: cubit.isDark,
                      onChanged:(value){
                        cubit.changeSwitchValue(value);
                      },
                      title: Text("الوضـــع المظــلم"),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                 SizedBox(height: 20,),
                 Column(
                   children: [
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 10,),
                       alignment: Alignment.topRight,
                       child: Text("تغييــر ال API Key",
                       style: TextStyle(
                         color:cubit.isDark ? Colors.white: Color(0xff0c201a),
                         fontSize: 16,
                         fontWeight: FontWeight.bold
                       ),
                       textAlign: TextAlign.start,),
                     ),
                     SizedBox(height: 10,),
                     Container(
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           border: Border.all(color:cubit.isDark ? Colors.white: Color(0xff0c201a), )
                       ),
                       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                       // margin: EdgeInsets.symmetric(horizontal: 10),
                       child: DropdownButtonHideUnderline(
                         child: DropdownButtonFormField(
                           decoration: InputDecoration(
                             border: InputBorder.none,
                             fillColor: cubit.isDark ?  Color(0xff0c201a):Colors.white,
                             filled: true,
                             hintText: "تتغييــر ال API KEY ",
                             hintStyle: TextStyle(
                               color: cubit.isDark ?  Colors.white:Color(0xff0c201a),
                             ),
                           ),
                           value: cubit.apiKeyPlaceholder,
                           items: cubit.apiKeysListPlaceholder.map((e){
                             return DropdownMenuItem(
                                 value: e,
                                 child: Text(e.toString(),style: TextStyle(
                             color: Colors.deepOrange ,),),
                             );
                           }).toList(),
                           onChanged: (value){
                             cubit.changeApiKeyManually(value);
                             showNotify(context,"تم التغييــر",cubit.isDark,);
                           },
                         ),
                       ),
                     ),
                   ],
                 )
                ],
              ),
            ),
          );
        });
  }
}
