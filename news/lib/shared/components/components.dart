import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/modules/news/web_view/web_view.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as snip;


Widget showNotify(context,String msg,bool isDark,{position=0}){
      Toast.show(
        msg,
        context,
        gravity: position,
        duration: 3,
        backgroundColor: isDark?Color(0xff0c201a):Colors.white,
        textColor: isDark?Colors.white:Color(0xff0c201a),
        border: Border.all(
          color: isDark?Colors.white:Color(0xff0c201a),
          width: 1
        )
      );
}

Widget circularLoading(context){
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width+100,
      child: Center(
          child: snip.SpinKitFadingFour(
            duration: Duration(seconds: 1),
            color: Colors.deepOrange,
          ),
      ));
}
Widget BuildCategoriesItem(
    {@required BuildContext context, @required String image,@required String category}){
 return  Container(
   height: 100,
   width: 160,
   margin: const EdgeInsets.symmetric(horizontal: 5),
   clipBehavior: Clip.antiAliasWithSaveLayer,
   decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(10),
   ),
   child: Stack(
     children: [
       Image.asset(image,width: 160,height: 100,fit: BoxFit.cover,),
       Container(
         width: double.infinity,
         height: double.infinity,
         color: Colors.black.withOpacity(.3),
         alignment: Alignment.center,
         child: Text(category,style: Theme.of(context).textTheme.headline2,),
       )
     ],
   ),
 );
}


Widget buildArticleItem(context, list){
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewPage(url: list['url'])));
    },
    child: Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey,width: 1),
              left: BorderSide(color: Colors.grey,width: 1),
              right: BorderSide(color: Colors.grey,width: 1),
            ),
          ),
          child:
          list['urlToImage']!=null?
          CachedNetworkImage(
            imageUrl: list['urlToImage'].toString(),
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 400),
            errorWidget: (context,url,error)=>Icon(Icons.error),
            placeholder: (context,url)=>Image.asset('assets/newsImages/placeholder.png',fit: BoxFit.cover,),
          ):
          Image.asset('assets/newsImages/loading.gif',fit: BoxFit.fitWidth,),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey,width: 1),
            border: Border(
              left: BorderSide(color: Colors.grey,width: 1),
              right: BorderSide(color: Colors.grey,width: 1),
            ),
          ),
          child: Column(
            children: [
              Text(list['title'],style:Theme.of(context).textTheme.subtitle1,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10,),
              Text(" بتــــاريـخ :  ${list['publishedAt'].toString().substring(0,10)}",style: Theme.of(context).textTheme.subtitle2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,)
            ],
          ),
        ),
      ],
    ),
  );
}
Widget buildSaveSection(context,{String optionText = "إضـافة للمحفــوظات",IconData iconData=Icons.save_alt_outlined}){
  return Container(
    decoration: BoxDecoration(
        border : Border.all(
          color: Colors.grey,
          width: .7,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        )
    ),
    alignment: Alignment.topCenter,
    padding : EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    margin : EdgeInsets.symmetric(horizontal: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(optionText,style: Theme.of(context).textTheme.headline3,),
        SizedBox(width: 20,),
        Icon(iconData,size: 30,),
      ],
    ),
  );
}

Widget EmptyList(context,String text){
  var width=MediaQuery.of(context).size.width;
  return Center(
    child: Stack(
      alignment: Alignment(.2,0),
      children: [
        Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        width: width - 60,
        height: width,
        child: Image.asset(
          "assets/newsImages/sign.jpg",
          fit: BoxFit.cover,
        ),
      ),
        Container(
          width: width/3+50,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xff0c201a),
            borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(text,style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            height: 2
          ),textAlign: TextAlign.center,),)
    ]),
  );
}
Widget EmptyListForConnectionState(context,String text){
  var width=MediaQuery.of(context).size.width;
  return Center(
    child: Stack(
        alignment: Alignment(.2,0),
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            width: width - 130,
            height: width-80,
            child: Image.asset(
              "assets/newsImages/sign.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: width/3+50,
            height: 100,
            decoration: BoxDecoration(
                color: Color(0xff0c201a),
                borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Text(text,style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 2
            ),textAlign: TextAlign.center,),)
        ]),
  );
}

Widget noInternetConnection(context,bool isDark ,Color darkColor,lightColor,Function function){
  return  Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        EmptyListForConnectionState(context,"الرجــاء الاتصـال بالشـبكة"),
        SizedBox(height: 50,),
        Container(
          decoration: BoxDecoration(
              color: isDark?lightColor:darkColor,
              border: Border.all(
                  color: isDark?darkColor:lightColor,
                  width: 1
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
          child: InkWell(
            child: Text("تـحــــديـث",style: TextStyle(
              color: isDark?darkColor:lightColor,
            ),),
            onTap: (){
              function();
            },
          ),
        )
      ],
    ),
  );
}



Widget buildArticleItem22(context, list){
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewPage(url: list['url'])));
    },
    child: Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey,width: 1),
              left: BorderSide(color: Colors.grey,width: 1),
              right: BorderSide(color: Colors.grey,width: 1),
            ),
          ),
          child:
          list['image_url']!=null?
          CachedNetworkImage(
            imageUrl: list['image_url'].toString(),
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 400),
            errorWidget: (context,url,error)=>Icon(Icons.error),
            placeholder: (context,url)=>Image.asset('assets/newsImages/placeholder.png',fit: BoxFit.cover,),
          ):
          Image.asset('assets/newsImages/loading.gif',fit: BoxFit.fitWidth,),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey,width: 1),
            border: Border(
              left: BorderSide(color: Colors.grey,width: 1),
              right: BorderSide(color: Colors.grey,width: 1),
            ),
          ),
          child: Column(
            children: [
              Text(list['title'],style:Theme.of(context).textTheme.subtitle1,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10,),
              Text(" بتــــاريـخ :  ${list['date'].toString().substring(0,10)}",style: Theme.of(context).textTheme.subtitle2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,)
            ],
          ),
        ),
      ],
    ),
  );
}
Widget buildSavedArticleItem(context, list){
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewPage(url: list['url'])));
    },
    child: Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child:
          list['image_url']!=null?
          CachedNetworkImage(
            imageUrl: list['image_url'].toString(),
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 400),
            errorWidget: (context,url,error)=>Icon(Icons.error),
            placeholder: (context,url)=>Image.asset('assets/newsImages/placeholder.png',fit: BoxFit.cover,),
          ):
          Image.asset('assets/newsImages/loading.gif',fit: BoxFit.fitWidth,),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey,width: 1),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Text(list['title'],style:Theme.of(context).textTheme.subtitle1,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10,),
              Text(" بتــــاريـخ :  ${list['date'].toString().substring(0,10)}",style: Theme.of(context).textTheme.subtitle2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,)
            ],
          ),
        ),
      ],
    ),
  );
}