import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';
import 'package:to_do_new/shared/view_model/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_new/tasks/data/firebase_function.dart';
import 'package:to_do_new/tasks/view/widget/edit_sheet.dart';
import 'package:to_do_new/tasks/view_model/task_model.dart';
import 'package:to_do_new/tasks/view_model/tasks_provider.dart';

class TaskItem extends StatefulWidget {
  TaskItem({super.key, required this.task});
  TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    TasksProvider taskProvider = Provider.of<TasksProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                FirebaseFunction.deleteTaskForomFireStore(widget.task.id)
                    .timeout(Duration(milliseconds: 100), onTimeout: () {
                  Provider.of<TasksProvider>(context, listen: false)
                      .getAllTasksFormFireBase();
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!.taskDeleted,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }).catchError((e) {
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!.somethingWentWrong,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              onPressed: (_) {
                Navigator.pushNamed(context, EditSheet.routeName,
                    arguments: widget.task);
              },
              backgroundColor: AppTheme.primaryColorLight,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 4,
                  height: 60,
                  color: widget.task.isDone
                      ? AppTheme.green
                      : AppTheme.primaryColorLight),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.task.title,
                    style: textTheme.titleLarge!.copyWith(
                        color: widget.task.isDone
                            ? AppTheme.green
                            : AppTheme.primaryColorLight),
                  ),
                  Text(
                    widget.task.descrption,
                    style:
                        textTheme.titleSmall!.copyWith(color: AppTheme.black),
                  ),
                ],
              ),
              Spacer(),
              widget.task.isDone
                  ? TextButton(
                      onPressed: () {
                        widget.task.isDone = !widget.task.isDone;
                        FirebaseFunction.editIsDone(widget.task);
                        setState(() {});
                      },
                      child: Text(
                        'Done!',
                        style: textTheme.labelLarge!.copyWith(
                            color: widget.task.isDone
                                ? AppTheme.green
                                : AppTheme.primaryColorLight),
                      ))
                  : Container(
                      width: 69,
                      height: 34,
                      // color: AppTheme.primaryColorLight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.primaryColorLight),

                      child: IconButton(
                          onPressed: () {
                            widget.task.isDone = !widget.task.isDone;
                            FirebaseFunction.editIsDone(
                              widget.task,
                              // FirebaseAuth.instance.currentUser!.uid
                            );
                            setState(() {});
                          },
                          style: ButtonStyle(),
                          color: AppTheme.white,
                          icon: Icon(Icons.done)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
