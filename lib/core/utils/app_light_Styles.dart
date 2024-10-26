import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';

class ApplightStyle{
  static TextStyle appBarTextStyle =GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.white);
  static TextStyle bottomSheetTitle =GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: ColorsManager.black);
  static TextStyle hintStyle =GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w400,color: ColorsManager.grey);
  static TextStyle dateLabelStyle =GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w400,color: ColorsManager.black);
  static TextStyle dateStyle =GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w400,color: ColorsManager.grey);

}