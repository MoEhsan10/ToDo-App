import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/dataBase_Manager/model/todo_dm.dart';
import 'package:todo_app/dataBase_Manager/model/user_dm.dart';

class TaskBottomsheet extends StatefulWidget {
  TaskBottomsheet({super.key});

  @override
  State<TaskBottomsheet> createState() => _TaskBottomsheetState();


  static Future show(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: TaskBottomsheet(),
          );
        });
  }
}

class _TaskBottomsheetState extends State<TaskBottomsheet> {
  DateTime selectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          // Ensures the bottom sheet doesn't take up unnecessary space
          children: [
            Text(
              'Add new Task',
              textAlign: TextAlign.center,
              style: ApplightStyle.bottomSheetTitle,
            ),
            SizedBox(height: 8),
            TextFormField(
              validator: (input) {
                if(input==null || input.trim().isEmpty){
                  return 'Please Enter Task title';
                }
              } ,
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter your task title',
                hintStyle: ApplightStyle.hintStyle,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              validator: (input) {
                if(input==null || input.trim().isEmpty){
                  return 'Please Enter Task Description';
                }
                if(input.length<6){
                  return 'Description should be at least 6 characters';
                }
                return null;
              } ,
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter your task description',
                hintStyle: ApplightStyle.hintStyle,
              ),
            ),
            SizedBox(height: 12),
            Text('Select Date', style: ApplightStyle.dateLabelStyle),
            SizedBox(height: 8),
            InkWell(
              onTap: () {
                ShowTaskDatePicker();
              },
              child: Text(
                selectedDate.toFormattedDate,
                textAlign: TextAlign.center,
                style: ApplightStyle.dateStyle,
              ),
            ),
            SizedBox(height: 12), // Replace Spacer to limit height
            ElevatedButton(
              onPressed: () {
                addTaskToFireStore();
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  void ShowTaskDatePicker() async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ) ??
        selectedDate;
    setState(() {});
  }


  addTaskToFireStore() {
    if (formKey.currentState?.validate() == false) return;
    var db = FirebaseFirestore.instance;
    CollectionReference collectionReference = db
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference newDoc =
    collectionReference.doc();

    TodoDM todo = TodoDM(
      id: newDoc.id,
      title: titleController.text,
      dateTime: selectedDate.copyWith(
        second: 0,
        microsecond: 0,
        hour: 0,
        millisecond: 0,
        minute: 0,
      ),
      description: descriptionController.text,
      isDone: false,
    );
    newDoc.set(todo.toFireStore()).then((_) {
        Navigator.pop(context);
    })
        .onError((error, stackTrace) {
    })
        .timeout(
      const Duration(milliseconds: 500),
      onTimeout: () {
        Navigator.pop(context);
        print('Timeout');
      },
    );
  }

}
