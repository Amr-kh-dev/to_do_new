import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';
import 'package:to_do_new/shared/view/view_model/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
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
              onPressed: (_) {},
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              onPressed: (_) {},
              backgroundColor: AppTheme.primaryColorLight,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: 4,
                height: 36,
                color: settingProvider.isDone
                    ? AppTheme.green
                    : AppTheme.primaryColorLight),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'basket ball',
                  style: textTheme.titleLarge!.copyWith(
                      color: settingProvider.isDone
                          ? AppTheme.green
                          : AppTheme.primaryColorLight),
                ),
                Text(
                  'base ball',
                  style: textTheme.titleSmall!.copyWith(
                      color: settingProvider.isDone
                          ? AppTheme.white
                          : AppTheme.black),
                ),
              ],
            ),
            settingProvider.isDone
                ? TextButton(
                    onPressed: () {
                      settingProvider.toggleDone();
                    },
                    child: Text(
                      'Done!',
                      style: textTheme.labelLarge!.copyWith(
                          color: settingProvider.isDone
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
                          settingProvider.toggleDone();
                        },
                        style: ButtonStyle(),
                        color: AppTheme.white,
                        icon: Icon(Icons.done)),
                  ),
          ],
        ),
      ),
    );
  }
}
