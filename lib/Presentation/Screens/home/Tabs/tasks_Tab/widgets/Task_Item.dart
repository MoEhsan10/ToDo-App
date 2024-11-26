import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/Presentation/Screens/home/Tabs/tasks_Tab/Tasks_Tab.dart';
import 'package:todo_app/core/firebase/firebase_Functions/firebase_functions.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/core/utils/routes_Manager.dart';
import 'package:todo_app/dataBase_Manager/model/todo_dm.dart';
import 'package:todo_app/dataBase_Manager/model/user_dm.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.todo,
    required this.onDeletedTask,
  });

  final TodoDM todo;
  final VoidCallback onDeletedTask;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isDone;

  @override
  void initState() {
    super.initState();
    isDone = widget.todo.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              onPressed: (context) async {
                // Delete task from Firestore and update UI
                await deleteTodoFromFireStore(widget.todo);
                widget.onDeletedTask();
              },
              backgroundColor: ColorsManager.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(
                  context,
                  RoutesManager.editRoute,
                  arguments: DataToUpdateScreen(
                    todo: widget.todo,
                    todoKey: GlobalKey(), // Add a key for UI refresh
                  ),
                );
              },
              backgroundColor: ColorsManager.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDone
                      ? Colors.green
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 7),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todo.title,
                    style: ApplightStyle.taskStyle?.copyWith(
                      color: isDone
                          ? Colors.green
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.todo.description,
                    style: ApplightStyle.taskDescriptionStyle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.todo.dateTime.toFormattedDate,
                    style: ApplightStyle.taskDate,
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  // Mark task as "done" and delete from Firestore
                  setState(() {
                    isDone = true;
                  });
                  await deleteTodoFromFireStore(widget.todo);
                  widget.onDeletedTask();
                },
                child: isDone
                    ? Text(
                  'Done!',
                  style: ApplightStyle.taskStyle?.copyWith(
                    color: Colors.green,
                  ),
                )
                    : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: ColorsManager.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteTodoFromFireStore(TodoDM todo) async {
    final todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    await todoCollection.doc(todo.id).delete();
  }
}


class DataToUpdateScreen{
TodoDM todo;
var todoKey;

DataToUpdateScreen({required this.todo,required this.todoKey});
}
