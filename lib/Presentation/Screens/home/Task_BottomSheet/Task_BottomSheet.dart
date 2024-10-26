import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/date_utils.dart';

class TaskBottomsheet extends StatefulWidget {
   TaskBottomsheet({super.key});
  @override
  State<TaskBottomsheet> createState() => _TaskBottomsheetState();

  static Widget show() => TaskBottomsheet();
}

class _TaskBottomsheetState extends State<TaskBottomsheet> {
DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add new Task', textAlign: TextAlign.center,
            style: ApplightStyle.bottomSheetTitle,),
          SizedBox(height: 8,),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your task title',
              hintStyle: ApplightStyle.hintStyle,
            ),
          ),
          SizedBox(height: 8,),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your task description',
              hintStyle: ApplightStyle.hintStyle,
            ),
          ),
          SizedBox(height: 12,),
          Text('Select Date', style: ApplightStyle.dateLabelStyle,),
          SizedBox(height: 8,),
          InkWell(
              onTap: () {
                ShowTaskDatePicker();
              },
              child: Text(
                selectedDate.toFormattedDate, textAlign: TextAlign.center,
                style: ApplightStyle.dateStyle,)),
          Spacer(),
          ElevatedButton(onPressed: () {

          }, child: Text('Add Task'))
        ],
      ),
    );
  }

  void ShowTaskDatePicker() async{
   selectedDate=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
    )?? selectedDate;
   setState(() {

   });
  }
}
