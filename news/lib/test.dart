import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layouts/news/cubit/cubit.dart';
import 'package:news/layouts/news/cubit/states.dart';
import 'package:news/shared/components/components.dart';

class Test extends StatefulWidget {
  const Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsAppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body:
                cubit.connectionState?
            ListView.separated(
              controller: cubit.listViewController,
              separatorBuilder: (context, index) =>
                  Container(
                    height: 100,
                    width: 300,
                    color: Colors.blue,
                  ),
              itemBuilder: (context, index) =>
                  Container(
                    height: 100,
                    width: 300,
                    color: Colors.red,
                  ),
              itemCount: 20,
            ):
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EmptyList(context,"لا يوجد اتصال بالشبكة"),
                          SizedBox(height: 50,),
                          Container(
                            decoration: BoxDecoration(
                              color: cubit.isDark?Colors.white:Color(0xff0c201a),
                              border: Border.all(
                                color: cubit.isDark?Color(0xff0c201a):Colors.white,
                                width: 1
                              ),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                            child: InkWell(
                              child: Text("تـحــــديـث",style: TextStyle(
                                color: cubit.isDark?Color(0xff0c201a):Colors.white,
                              ),),
                              onTap: (){
                                cubit.checkNetwork();
                              },
                            ),
                          )
                        ],
                      ),
                    )
            ,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.keyboard_arrow_up_outlined),
              onPressed: (){
                cubit.scrollUp();
              },
            ),
          );
        },
      ),
    );
  }
}
