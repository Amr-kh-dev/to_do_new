import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';
import 'package:to_do_new/shared/view/view_model/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    return Row(
      children: [
        Text(AppLocalizations.of(context)!.logOut,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color:
                    settingProvider.isDark ? AppTheme.white : AppTheme.black)),
        Spacer(),
        IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            style: ButtonStyle(
                iconColor: WidgetStatePropertyAll(settingProvider.isDark
                    ? AppTheme.primaryColorDark
                    : AppTheme.black)),
            onPressed: () {})
      ],
    );
  }
}
