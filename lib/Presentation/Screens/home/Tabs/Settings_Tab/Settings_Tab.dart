import 'package:flutter/material.dart';
import 'package:todo_app/Presentation/Screens/home/Tabs/Settings_Tab/%D9%8BWIdget/Language_Dropdown.dart';
import 'package:todo_app/Presentation/Screens/home/Tabs/Settings_Tab/%D9%8BWIdget/ThemeMode_Dropdown.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.all(20.0),
      // Adjust padding for a centered layout
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 20), // Spacing between title and dropdowns
          LanguageDropdown(),
           SizedBox(height: 20), // Spacing between dropdowns
          ThememodeDropdown(),
        ],
      ),
    );
  }

// Widget buildDropdownSection(String title, String initialValue) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         title,
//         style: TextStyle(
//           color: ColorsManager.black,
//           fontSize: 16,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//       const SizedBox(height: 10), // Spacing between label and dropdown
//       Container(
//         width: 319,
//         height: 48,
//         decoration: BoxDecoration(
//           color: ColorsManager.white,
//           borderRadius: BorderRadius.circular(4),
//           border: Border.all(
//             color: ColorsManager.blue,
//             width: 1.5,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 initialValue,
//                 style: TextStyle(
//                   color: ColorsManager.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_drop_down,
//                 color: ColorsManager.blue,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
}

