import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/settings/view_model/language_model.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';
import 'package:to_do_new/shared/view_model/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DropdownbuttonToSwitchLanguage extends StatelessWidget {
  DropdownbuttonToSwitchLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LanguageModel> languages = [
      LanguageModel(
          languageName: AppLocalizations.of(context)!.english,
          languageCode: 'en'),
      LanguageModel(
          languageName: AppLocalizations.of(context)!.arbiac,
          languageCode: 'ar'),
    ];
    final settingProvider = Provider.of<SettingProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          // 'Language:',

          AppLocalizations.of(context)!.language,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: settingProvider.isDark ? AppTheme.white : AppTheme.black),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<LanguageModel>(
            value: languages.firstWhere(
              (lang) => lang.languageCode == settingProvider.locale.toString(),
            ),
            items: languages
                .map(
                  (language) => DropdownMenuItem<LanguageModel>(
                    value: language,
                    child: Text(
                      language.languageName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: settingProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black),
                    ),
                  ),
                )
                .toList(),
            onChanged: (selectedLanguage) {
              if (selectedLanguage != null) {
                settingProvider.changeLocale(selectedLanguage.languageCode);
              }
            },
            borderRadius: BorderRadius.circular(25),
            dropdownColor: settingProvider.isDark
                ? AppTheme.primaryColorLight
                : AppTheme.white,
          ),
        ),
      ],
    );
  }
}
