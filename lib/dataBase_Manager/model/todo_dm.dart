import 'package:flutter/cupertino.dart';

class TodoDM{
  static const String collectionName='todo';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  TodoDM({required this.id,required this.title,required this.dateTime,required this.description,required this.isDone});

  Map<String,dynamic> toFireStore()=>{
    'id' : id,
    'title' :title,
    'description':description,
    'dateTime':dateTime,
    'isDone' : isDone,
  };

  TodoDM.fromFireStore(Map<String,dynamic> data):this(
    id :data['id'],
    title:data['title'],
    description:data['description'],
    dateTime: data['dateTime'].toDate(),
    isDone:data['isDone'],
  );
}