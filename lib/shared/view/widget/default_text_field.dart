import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';
import 'package:to_do_new/shared/view/view_model/app_theme.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validator});
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return Container(
        color: settingProvider.isDark ? AppTheme.gry : AppTheme.white,
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelText: hintText,
          ),
          controller: controller,
          validator: validator,
        ));
  }
}
