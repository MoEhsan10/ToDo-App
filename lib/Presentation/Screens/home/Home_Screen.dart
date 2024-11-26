import 'package:flutter/material.dart';
import 'package:todo_app/Presentation/Screens/home/Tabs/Settings_Tab/Settings_Tab.dart';
import 'package:todo_app/Presentation/Screens/home/Tabs/tasks_Tab/Tasks_Tab.dart';
import 'package:todo_app/Presentation/Screens/home/Task_BottomSheet/Task_BottomSheet.dart';
import 'package:todo_app/core/utils/assets_Manager.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TasksTabState> tasksTabKey=GlobalKey();
int currentIndex=0;
List<Widget> tabs=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs=[
      TasksTab(key: tasksTabKey,),
      SettingsTab(),

    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      appBar: AppBar(
        backgroundColor: ColorsManager.blue,
        title: Text('To Do List',style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: tabs[currentIndex],
      extendBody: true,
    );
  }

buildBottomNavigationBar()=> BottomAppBar(
  notchMargin: 8,
  child: BottomNavigationBar(
    currentIndex: currentIndex,
      onTap: onTapped,
      items: [
      BottomNavigationBarItem(icon: Icon(Icons.list),label: 'List'),
      BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
      ] ),
);

  void onTapped(int index){
    currentIndex=index;
    setState(() {

    });
  }

  Widget buildFab() => FloatingActionButton(
    onPressed: () async {
      await TaskBottomsheet.show(context); // stop
      tasksTabKey.currentState?.getTodosFromFireStore();
    },
    child: const Icon(
      Icons.add,
    ),
  );

}