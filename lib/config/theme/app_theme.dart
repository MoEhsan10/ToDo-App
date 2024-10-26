import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: false,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blue,
      titleTextStyle: ApplightStyle.appBarTextStyle
    ),
    scaffoldBackgroundColor: ColorsManager.scaffoldBg,
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.blue,
      unselectedItemColor: ColorsManager.grey,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blue,
      shape: StadiumBorder(side: BorderSide(color: Colors.white,width: 4))
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      shape: CircularNotchedRectangle(),
      color: Colors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      backgroundColor: Colors.white,
    )
  );
}
