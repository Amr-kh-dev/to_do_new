import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String descrption;
  DateTime dateTime;
  bool isDone;
  TaskModel(
      {this.id = '',
      required this.descrption,
      required this.dateTime,
      this.isDone = false,
      required this.title});

  factory TaskModel.formJeson(Map<String, dynamic> jeson) {
    return TaskModel(
        dateTime: (jeson['dateTime'] as Timestamp).toDate(),
        descrption: jeson['description'],
        title: jeson['title'],
        id: jeson['id'],
        isDone: jeson['isDone']);
  }

  Map<String, dynamic> toJeson() {
    return {
      'id': id,
      'title': title,
      'description': descrption,
      'dateTime': Timestamp.fromDate(dateTime),
      "isDone": isDone,
    };
  }
}
