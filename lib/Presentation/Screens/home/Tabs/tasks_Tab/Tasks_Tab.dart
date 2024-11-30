import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Presentation/Screens/home/Tabs/tasks_Tab/widgets/Task_Item.dart';
import 'package:todo_app/Presentation/Screens/home/Task_BottomSheet/Task_BottomSheet.dart';
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
  DateTime calenderSelectedDate = DateTime.now();
  List<TodoDM> todosList = [];

  @override
  void initState() {
    super.initState();
    getTodosFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            buildCalendarTimeLine(),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskItem(
                todo: todosList[index],
                onDeletedTask: () {
                  getTodosFromFireStore();
                },
              );
            },
            itemCount: todosList.length,
          ),
        ),
      ],
    );
  }

  // Widget buildCalenderTimeLine() => EasyInfiniteDateTimeLine(
  //   firstDate: DateTime.now().subtract(const Duration(days: 365)),
  //   focusDate: calenderSelectedDate,
  //   lastDate: DateTime.now().add(const Duration(days: 365)),
  //   onDateChange: (selectedDate) {
  //     setState(() {
  //       calenderSelectedDate = selectedDate;
  //       getTodosFromFireStore();
  //     });
  //   },
  //   itemBuilder: (context, date, isSelected, onTap) {
  //     final isActiveDay = date.day == calenderSelectedDate.day &&
  //         date.month == calenderSelectedDate.month &&
  //         date.year == calenderSelectedDate.year;
  //
  //     return InkWell(
  //       onTap: () {
  //         setState(() {
  //           calenderSelectedDate = date;
  //           getTodosFromFireStore();
  //         });
  //       },
  //       child: Card(
  //         color: ColorsManager.white,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               '${date.day}',
  //               style: isActiveDay
  //                   ? ApplightStyle.calenderSelectedItem?.copyWith(
  //                 color: ColorsManager.blue,
  //                 fontWeight: FontWeight.bold,
  //               )
  //                   : ApplightStyle.calenderUnSelectedItem?.copyWith(
  //                 color: ColorsManager.black,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //             Text(
  //               date.getDayName,
  //               style: isActiveDay
  //                   ? ApplightStyle.calenderSelectedItem?.copyWith(
  //                 color: ColorsManager.blue,
  //                 fontWeight: FontWeight.bold,
  //               )
  //                   : ApplightStyle.calenderUnSelectedItem?.copyWith(
  //                 color: ColorsManager.black,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   },
  // );
  Widget buildCalendarTimeLine() => EasyDateTimeLine(
    initialDate: DateTime.now(),
    onDateChange: (selectedDate) {
      setState(() {
        calenderSelectedDate = selectedDate;
        getTodosFromFireStore();
      });
    },
    headerProps: const EasyHeaderProps(
      showHeader: true, // Enable the header
      monthPickerType: MonthPickerType.dropDown,
      monthStyle:  TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      dateFormatter:  DateFormatter.fullDateDMY(),
     padding:  EdgeInsets.symmetric(horizontal: 16),
    ),
    dayProps: EasyDayProps(
      dayStructure: DayStructure.dayStrDayNum,
      activeDayStyle: DayStyle(
        dayNumStyle: ApplightStyle.calenderSelectedItem,
        dayStrStyle: ApplightStyle.calenderSelectedItem,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      inactiveDayStyle:  DayStyle(
        dayNumStyle: ApplightStyle.calenderUnSelectedItem,
        dayStrStyle: ApplightStyle.calenderUnSelectedItem,
        decoration:const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
  ));




  void getTodosFromFireStore() async {
    final db = FirebaseFirestore.instance;
    final CollectionReference todoCollection = db
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);

    final QuerySnapshot collectionSnapshot = await todoCollection
        .where(
      'dateTime',
      isEqualTo: calenderSelectedDate.copyWith(
        second: 0,
        microsecond: 0,
        hour: 0,
        millisecond: 0,
        minute: 0,
      ),
    )
        .get();
    print('hello');

    final List<QueryDocumentSnapshot> documentsSnapshot =
        collectionSnapshot.docs;

    setState(() {
      todosList = documentsSnapshot.map((docSnapShot) {
        final Map<String, dynamic> json =
        docSnapShot.data() as Map<String, dynamic>;
        return TodoDM.fromFireStore(json);
      }).toList();
    });
  }
}


