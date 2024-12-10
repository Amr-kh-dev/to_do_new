import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_new/shared/view_model/app_theme.dart';

class SwitchModeToggle extends StatelessWidget {
  const SwitchModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.darkmode,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: settingProvider.isDark ? AppTheme.white : AppTheme.black),
        ),
        Switch(
          value: settingProvider.isDark,
          onChanged: (value) {
            settingProvider.changeThemeMode();
          },
          activeTrackColor: settingProvider.isDark
              ? AppTheme.primaryColorLight
              : settingProvider.isDark
                  ? AppTheme.primaryColorLight
                  : AppTheme.white,
        ),
      ],
    );
  }
}
