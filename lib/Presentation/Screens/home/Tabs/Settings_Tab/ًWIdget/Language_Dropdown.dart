import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  LanguageDropdownState createState() => LanguageDropdownState();
}

class LanguageDropdownState extends State<LanguageDropdown> {
  final List<String> langList = [
    'English',
    'العربية',
  ];

  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language',
          style: ApplightStyle.settingsHead,
        ),
        const SizedBox(height: 10),
        Container(
          width: 319,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: ColorsManager.blue,
              width: 1.5,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              isExpanded: false,
              icon:const Icon(
                Icons.arrow_drop_down,
                color: ColorsManager.blue,
              ),
              style: ApplightStyle.settingsSelectedTitle,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
              items: langList.map<DropdownMenuItem<String>>((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(
                    language,
                    style: GoogleFonts.inter(
                      color: language == selectedLanguage
                          ? ColorsManager.blue // Selected color
                          : ColorsManager.black, // Unselected color
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
