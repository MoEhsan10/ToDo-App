import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/assets_Manager.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';
import 'package:todo_app/core/utils/routes_Manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    });
  }
  @override
  Widget build(BuildContext context) {


    return Container(
      color: ColorsManager.scaffoldBg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsManager.splashLogo, width: 198, height: 211),
        ],
      ),
    );
  }
}
