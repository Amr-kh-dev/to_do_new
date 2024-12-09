import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';
import 'package:to_do_new/shared/view/view_model/app_theme.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({super.key, required this.label, required this.onClick});
  String label;
  void Function() onClick;

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return ElevatedButton(
        onPressed: onClick,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: 52,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color:
                      settingProvider.isDark ? AppTheme.white : AppTheme.black),
            ),
          ),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: settingProvider.isDark
                ? const Color.fromARGB(255, 20, 87, 143)
                : AppTheme.primaryColorLight,
          ),
        ));
  }
}
