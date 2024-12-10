import 'package:flutter/material.dart';
import 'package:to_do_new/settings/view/widget/Dropdownbutton_to_switch_language.dart';
import 'package:to_do_new/settings/view/widget/log_out.dart';
import 'package:to_do_new/settings/view/widget/switch_mode_togel.dart';

import 'package:to_do_new/shared/view_model/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  static String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: height * 0.17,
              color: AppTheme.primaryColorDark,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Text(
                  AppLocalizations.of(context)!.settings,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          LogOut(),
          const SizedBox(
            height: 20,
          ),
          SwitchModeToggle(),
          const SizedBox(
            height: 20,
          ),
          DropdownbuttonToSwitchLanguage(),
        ],
      ),
    );
  }
}
