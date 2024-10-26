import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/Presentation/Screens/home/Home_Screen.dart';
import 'package:todo_app/Presentation/Screens/splah/Splash_Screen.dart';


class RoutesManager{
  static const String homeRoute='/home';
  static const String splahRoute='/splash';
  static Route? router(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen(),);
      case splahRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen(),);
    }
  }
}