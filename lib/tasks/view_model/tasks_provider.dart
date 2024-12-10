import 'package:flutter/material.dart';
import 'package:to_do_new/tasks/data/firebase_function.dart';
import 'package:to_do_new/tasks/view_model/task_model.dart';

class TasksProvider with ChangeNotifier {
  // bool isDone = false;

  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  void toggleDone() {
    // isDone = !isDone;
    notifyListeners();
  }

  Future<void> getAllTasksFormFireBase() async {
    List<TaskModel> allTasks = await FirebaseFunction.getAllTaskCollection();
    tasks = allTasks
        .where((element) =>
            element.dateTime.year == selectedDate.year &&
            element.dateTime.month == selectedDate.month &&
            element.dateTime.day == selectedDate.day)
        .toList();
    notifyListeners();
  }

  void changeDate(DateTime date) {
    print("changeDate");
    selectedDate = date;
    getAllTasksFormFireBase();
  }

  Future<void> initializeTasks() async {
    await getAllTasksFormFireBase();
  }
}
