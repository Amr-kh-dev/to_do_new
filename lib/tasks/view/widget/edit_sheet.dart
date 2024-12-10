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

class EditSheet extends StatefulWidget {
  EditSheet({super.key});
  static const String routeName = "/EditSheet";

  @override
  State<EditSheet> createState() => _EditSheetState();
}

class _EditSheetState extends State<EditSheet> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController discretionEditingController = TextEditingController();
  DateFormat dateFormat = DateFormat('dd/MM/yy');
  TaskModel? task;

  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    if (task == null) {
      task = ModalRoute.of(context)?.settings.arguments as TaskModel;
      selectedDate = task!.dateTime;
      titleEditingController.text = task!.title;
      discretionEditingController.text = task!.descrption;
    }
    final height = MediaQuery.sizeOf(context).height;
    SettingProvider settingProvider = SettingProvider();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.toDoList,
          style: TextStyle(
              color: settingProvider.isDark ? AppTheme.black : AppTheme.white),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: AppTheme.primaryColorLight,
                height: height * 0.1,
              ),
              Container(
                height: height * 0.7,
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.editTask,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.black),
                      ),
                      DefaultTextField(
                        hintText: AppLocalizations.of(context)!.enterYourTask,
                        controller: titleEditingController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .titleonRequired;
                          }
                          return null;
                        },
                      ),
                      DefaultTextField(
                        hintText:
                            AppLocalizations.of(context)!.enterYourDscrbtion,
                        controller: discretionEditingController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .descriptionRequired;
                          }
                          return null;
                        },
                      ),
                      InkWell(
                          onTap: () async {
                            DateTime? dataTime = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)),
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly);
                            if (dataTime != null && dataTime != selectedDate) {
                              selectedDate = dataTime!;
                              setState(() {});
                            }
                          },
                          child: Column(
                            children: [
                              Text(AppLocalizations.of(context)!.selectTime),
                              Text(dateFormat.format(selectedDate)),
                            ],
                          )),
                      DefaultButton(
                        onClick: () {
                          if (formKey.currentState!.validate()) {
                            // print('object');
                            editTask();
                          }
                        },
                        label: AppLocalizations.of(context)!.edit,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void editTask() {
    if (formKey.currentState!.validate()) {
      task!.title = titleEditingController.text;
      task!.descrption = discretionEditingController.text;
      task!.dateTime = selectedDate;

      FirebaseFunction.editTask(task!).timeout(Duration(milliseconds: 1000),
          onTimeout: () {
        // print('5');
        Navigator.pop(context);
        Provider.of<TasksProvider>(context, listen: false)
            .getAllTasksFormFireBase();
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.editTask,
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
