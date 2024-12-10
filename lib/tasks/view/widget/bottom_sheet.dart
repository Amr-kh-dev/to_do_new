import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';
import 'package:to_do_new/shared/view_model/app_theme.dart';
import 'package:to_do_new/shared/view/widget/default_button.dart';
import 'package:to_do_new/shared/view/widget/default_text_Field.dart';
import 'package:to_do_new/tasks/data/firebase_function.dart';
import 'package:to_do_new/tasks/view_model/task_model.dart';
import 'package:to_do_new/tasks/view_model/tasks_provider.dart';

class ButtonSheet extends StatefulWidget {
  ButtonSheet({super.key});
  static String routeName = '/button-sheet';

  @override
  State<ButtonSheet> createState() => _ButtonSheetState();
}

class _ButtonSheetState extends State<ButtonSheet> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController discretionEditingController =
      TextEditingController();

  DateFormat dateFormat = DateFormat('dd/MM/yy');

  DateTime SelectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    // TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppLocalizations.of(context)!.addNewTask,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: settingProvider.isDark
                        ? AppTheme.white
                        : AppTheme.black),
              ),
              SizedBox(
                height: 40,
              ),
              DefaultTextField(
                hintText: AppLocalizations.of(context)!.enterYourTask,
                controller: titleEditingController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.titleonRequired;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              DefaultTextField(
                hintText: AppLocalizations.of(context)!.enterYourDscrbtion,
                controller: discretionEditingController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.descriptionRequired;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () async {
                    DateTime? dataTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                        initialEntryMode: DatePickerEntryMode.calendarOnly);
                    if (dataTime != null && dataTime != SelectedDate) {
                      SelectedDate = dataTime!;
                      setState(() {});
                    }
                  },
                  child: Column(
                    children: [
                      Text(AppLocalizations.of(context)!.selectTime),
                      Text(dateFormat.format(SelectedDate)),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              DefaultButton(
                onClick: () {
                  if (formKey.currentState!.validate()) {
                    addTask();
                  }
                },
                label: AppLocalizations.of(context)!.add,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    if (formKey.currentState!.validate()) {
      TaskModel task = TaskModel(
        descrption: discretionEditingController.text,
        dateTime: SelectedDate,
        title: titleEditingController.text,
      );

      FirebaseFunction.addTasksToFireStore(task).then((value) {
        Navigator.pop(context);
        Provider.of<TasksProvider>(context, listen: false)
            .getAllTasksFormFireBase();
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.taskAdded,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppTheme.primaryColorLight,
            textColor: Colors.white,
            fontSize: 16.0);
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.somethingWentWrong,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }
}
