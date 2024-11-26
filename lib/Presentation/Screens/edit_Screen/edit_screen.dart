import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Presentation/Screens/home/Tabs/tasks_Tab/widgets/Task_Item.dart';
import 'package:todo_app/core/firebase/firebase_Functions/firebase_functions.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/dataBase_Manager/model/todo_dm.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed to this screen
    final allData = ModalRoute.of(context)?.settings.arguments;
    if (allData == null || allData is! DataToUpdateScreen) {
      // Display error if arguments are missing or invalid
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'To Do List',
            style: ApplightStyle.appBarTextStyle,
          ),
        ),
        body: const Center(
          child: Text(
            'No task data available!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    // Access the todo data and initialize local variables
    final data = allData.todo;
    final todoKey = allData.todoKey; // Key for UI refresh
    final formatDate = ValueNotifier<String>(data.dateTime.toFormattedDate);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Edit Task',
          style: ApplightStyle.appBarTextStyle,
        ),
      ),
      body: Stack(
        children: [
          // Background Header Color
          Container(
            color: ColorsManager.blue,
            height: 90,
          ),
          // Main Content
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ColorsManager.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Screen Title
                  const Text(
                    'Edit Task',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Title Field
                  const Text('Title'),
                  TextFormField(
                    initialValue: data.title,
                    onChanged: (value) {
                      data.title = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Description Field
                  const Text('Description'),
                  TextFormField(
                    initialValue: data.description,
                    onChanged: (value) {
                      data.description = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Date Selector
                  const Text('Selected Date'),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<String>(
                    valueListenable: formatDate,
                    builder: (context, value, child) {
                      return InkWell(
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: data.dateTime,
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (selectedDate != null) {
                            data.dateTime = selectedDate;
                            formatDate.value = data.dateTime.toFormattedDate; // Update ValueNotifier
                          }
                        },
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  // Save Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      // Update Firestore and UI
                      await FireBaseFunctions.updateTask(data);
                      // Notify parent widget to refresh UI
                      todoKey?.currentState?.getTodosFromFireStore();
                      // Navigate back to the previous screen
                      Navigator.pop(context);
                    },
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


