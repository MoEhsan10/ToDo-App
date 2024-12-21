import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';

class ThememodeDropdown extends StatefulWidget {
  const ThememodeDropdown({super.key});

  @override
  State<ThememodeDropdown> createState() => _ThememodeDropdownState();
}

class _ThememodeDropdownState extends State<ThememodeDropdown> {
  final List<String> modeList = [
    'Light',
    'Dark',
  ];

  String selectedMode = 'Light';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mode',
          style: ApplightStyle.settingsHead,
        ),
        const SizedBox(height: 10), // Spacing between label and dropdown
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
              value: selectedMode,
              icon: Icon(
                Icons.arrow_drop_down,
                color: ColorsManager.blue,
              ),
              style: ApplightStyle.settingsSelectedTitle,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMode = newValue!;
                });
              },
              items: modeList.map<DropdownMenuItem<String>>((String mode) {
                return DropdownMenuItem<String>(
                  value: mode,
                  child: Text(mode,
                    style: GoogleFonts.inter(
                      color: mode == selectedMode
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
