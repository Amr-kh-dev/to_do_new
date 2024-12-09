import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/shared/view/view_model/app_theme.dart';
import 'package:to_do_new/tasks/data/firebase_function.dart';
import 'package:to_do_new/tasks/view/widget/task_item.dart';
import 'package:to_do_new/tasks/view_model/task_model.dart';
import 'package:to_do_new/tasks/view_model/tasks_provider.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool flags = true;
  List<TaskModel> tasks = [];
  bool shodeGetTasks = false;
  @override
  Widget build(BuildContext context) {
    // TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    // if (flags) {
    //   tasksProvider.getAllTasksFormFireBase();
    //   flags = false;
    // }
    if (shodeGetTasks) {
      getTasks();
      shodeGetTasks = false;
    }
    double hiegt = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: hiegt * 0.2,
              width: double.infinity,
              color: AppTheme.primaryColorLight,
            ),
            Padding(
                padding: EdgeInsetsDirectional.only(
                  start: width * 0.05,
                ),
                child: SafeArea(
                    child: Text(
                  AppLocalizations.of(context)!.toDoList,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ))),
            Padding(
              padding: EdgeInsetsDirectional.only(top: hiegt * 0.15),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                focusDate: DateTime.now(),
                //  tasksProvider.selectedDate,
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateChange: (selectedDate) {
                  // tasksProvider.changeDate(selectedDate);
                },
                showTimelineHeader: false,
                dayProps: EasyDayProps(
                  height: 79,
                  width: 58,
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dayNumStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColorLight),
                    dayStrStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColorLight),
                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dayNumStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.black),
                    dayStrStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.black),
                  ),
                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dayNumStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.black),
                    dayStrStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (_, index) => TaskItem(
            // task: tasksProvider.tasks[index],
            // task: TaskModel(
            //     descrption: 'asdfkads',
            //     dateTime: DateTime.now(),
            //     title: 'asdfkads'),
            task: tasks[0],
          ),
          itemCount: tasks.length,
          // tasksProvider.tasks.length,
        )),
      ],
    );
  }

  Future<void> getTasks() async {
    tasks = await FirebaseFunction.getAllTaskCollection();
    setState(() {});
  }
}
