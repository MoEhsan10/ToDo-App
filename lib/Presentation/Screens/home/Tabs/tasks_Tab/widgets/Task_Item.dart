import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/dataBase_Manager/model/todo_dm.dart';
import 'package:todo_app/dataBase_Manager/model/user_dm.dart';

class TaskItem extends StatelessWidget {
  TaskItem({super.key, required this.todo,required this.onDeletedTask});
  TodoDM todo;
  Function onDeletedTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Slidable(
        startActionPane: ActionPane(
            motion: DrawerMotion(), children:
        [
          SlidableAction(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15),
            ),
            onPressed: (context) {
              deleteTodoFromFireStore(todo);
              onDeletedTask;
            },
            backgroundColor: ColorsManager.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            autoClose: true,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: ColorsManager.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            autoClose: true,
          ),
        ]
        ),
        child: Container(
          // margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(12),
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
                  color:  Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(width: 7,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    todo.title,
                    style: ApplightStyle.taskStyle,
                  ),
                  SizedBox(height: 4,),
                  Text(
                    todo.description,
                    style: ApplightStyle.taskDescriptionStyle,
                  ),
                  SizedBox(height: 4,),
                  Text(
                    DateTime.now().toFormattedDate,
                    style: ApplightStyle.taskDate,
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:  Theme.of(context).primaryColor,
                  ),
                  child: Icon(
                    Icons.check,
                    color: ColorsManager.white,
                    size: 30,
                  )),

            ],
          ),
        ),
      ),
    );
  }

  void deleteTodoFromFireStore(TodoDM todo)async{
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference task = todoCollection.doc(todo.id);
    await task.delete();
  }
}
