import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';
import 'package:to_do_new/shared/view/view_model/app_theme.dart';
import 'package:to_do_new/shared/view/widget/default_button.dart';
import 'package:to_do_new/shared/view/widget/default_text_Field.dart';
import 'package:to_do_new/tasks/view_model/task_model.dart';

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
    return Padding(
      padding: const EdgeInsets.all(20),
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
                  color:
                      settingProvider.isDark ? AppTheme.white : AppTheme.black),
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
                child: Text(dateFormat.format(SelectedDate))),
            DefaultButton(
              onClick: () {
                addTask();
              },
              label: AppLocalizations.of(context)!.addNewTask,
            )
          ],
        ),
      ),
    );
  }

  void addTask() {
    if (formKey.currentState!.validate()) {
      TaskModel(
          id: '',
          descrption: discretionEditingController.text,
          dateTime: SelectedDate,
          title: titleEditingController.text,
          isDone: false);
      setState(() {});
    }
  }
}
