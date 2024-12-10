import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_new/home/view/screen/home_screen.dart';
import 'package:to_do_new/settings/view/screen/setting_screen.dart';
import 'package:to_do_new/settings/view_model/setting_Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_new/shared/view_model/app_theme.dart';
import 'package:to_do_new/tasks/view/widget/bottom_sheet.dart';
import 'package:to_do_new/tasks/view/widget/edit_sheet.dart';
import 'package:to_do_new/tasks/view_model/tasks_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingProvider(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingProvider>(
              create: (_) => SettingProvider()),
          ChangeNotifierProvider<TasksProvider>(create: (_) {
            final tasksProvider = TasksProvider();
            tasksProvider.initializeTasks();
            return tasksProvider;
          }),
        ],
        child: ToDoApp(),
      ),
    ),
  );
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SettingScreen.routeName: (context) => SettingScreen(),
        ButtonSheet.routeName: (context) => ButtonSheet(),
        EditSheet.routeName: (context) => EditSheet(),
      },
      initialRoute: HomeScreen.routeName,
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: settingProvider.themeMode,
      locale: settingProvider.locale,
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
    );
  }
}
