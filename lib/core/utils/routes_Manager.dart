import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/Presentation/Screens/auth/Login/Login_Screen.dart';
import 'package:todo_app/Presentation/Screens/auth/register/Register_Screen.dart';
import 'package:todo_app/Presentation/Screens/edit_Screen/edit_screen.dart';
import 'package:todo_app/Presentation/Screens/home/Home_Screen.dart';
import 'package:todo_app/Presentation/Screens/splah/Splash_Screen.dart';


class RoutesManager{
  static const String homeRoute='/home';
  static const String splashRoute='/splash';
  static const String registerRoute='/register';
  static const String loginRoute='/login';
  static const String editRoute='/edit';
  static Route? router(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen(),);
      case splashRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen(),);
      case registerRoute:
        return MaterialPageRoute(builder: (context) => Register(),);
      case loginRoute:
        return MaterialPageRoute(builder: (context) => Login(),);
      case editRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => EditScreen(),);
    }

  }
}