import 'package:flutter/material.dart';
import 'package:news/modules/news/mainScreen/main_screen.dart';
import 'dart:async';
class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin{
  Animation<double> _animation;
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 2))..repeat(reverse: false);
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear);
   Future.delayed(Duration(seconds: 3),(){
     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MainScreen()), (route) => false);
   });
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: width,
            height: width,
            child: RotationTransition(
               turns:_animation,
              child: Image.asset("assets/newsImages/splash.png",width:width,height: width ,fit: BoxFit.fitWidth,),
            ),
          ),
        ),
      ),
    );
  }
}
