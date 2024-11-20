import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Presentation/Screens/home/Tabs/tasks_Tab/widgets/Task_Item.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/dataBase_Manager/model/todo_dm.dart';
import 'package:todo_app/dataBase_Manager/model/user_dm.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  TasksTabState createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
DateTime calenderSelectedDate=DateTime.now();
List<TodoDM> todosList = [];
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodosFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            buildCalenderTimeLine(),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskItem(
                todo: todosList[index],
                onDeletedTask: (){
                  getTodosFromFireStore();
                },
              );
            },
            itemCount: todosList.length,
          ),
        )
      ],
    );
  }

Widget buildCalenderTimeLine() => EasyInfiniteDateTimeLine(
  firstDate: DateTime.now().subtract(const Duration(days: 365)),
  focusDate: calenderSelectedDate,
  lastDate: DateTime.now().add(const Duration(days: 365)),
  onDateChange: (selectedDate) {
    setState(() {
      calenderSelectedDate = selectedDate;
      getTodosFromFireStore(); // Fetch tasks based on the selected date
    });
  },
  itemBuilder: (context, date, isSelected, onTap) {
    final isActiveDay = date.day == calenderSelectedDate.day &&
        date.month == calenderSelectedDate.month &&
        date.year == calenderSelectedDate.year;

    return InkWell(
      onTap: () {
        setState(() {
          calenderSelectedDate = date;
          getTodosFromFireStore(); // Update tasks when the date changes
        });
      },
      child: Card(
        color: ColorsManager.white,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(8),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: isActiveDay
                  ? ApplightStyle.calenderSelectedItem?.copyWith(
                color: ColorsManager.blue,
                fontWeight: FontWeight.bold,
              )
                  : ApplightStyle.calenderUnSelectedItem?.copyWith(
                color: ColorsManager.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              date.getDayName,
              style: isActiveDay
                  ? ApplightStyle.calenderSelectedItem?.copyWith(
                color: ColorsManager.blue,
                fontWeight: FontWeight.bold,
              )
                  : ApplightStyle.calenderUnSelectedItem?.copyWith(
                color: ColorsManager.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  },
);



 void getTodosFromFireStore() async {
   var db = FirebaseFirestore.instance; //todo
   CollectionReference todoCollection = db
       .collection(UserDM.collectionName)
       .doc(UserDM.currentUser!.id)
       .collection(TodoDM.collectionName);
    QuerySnapshot collectionSnapshot = await todoCollection.where('dateTime',isEqualTo: calenderSelectedDate.copyWith(
      second: 0,
      microsecond: 0,
      hour: 0,
      millisecond: 0,
      minute: 0,
    )).get();
    List<QueryDocumentSnapshot> documentsSnapshot = collectionSnapshot.docs;
    setState(() {
      todosList = documentsSnapshot.map((docSnapShot) {
        Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
        TodoDM todo = TodoDM.fromFireStore(json);
        return todo;
      }).toList();
    // todosList= todosList.where((todo)=> todo.dateTime.day == calenderSelectedDate.day &&
    // todo.dateTime.month==calenderSelectedDate.month&&
    // todo.dateTime.year==calenderSelectedDate.year,).toList();

    setState(() {

    });
    });
  }
}


