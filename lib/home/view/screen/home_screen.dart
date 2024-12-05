import 'package:flutter/material.dart';
import 'package:to_do_new/settings/view/screen/setting_screen.dart';
import 'package:to_do_new/shared/view/view_model/app_theme.dart';
import 'package:to_do_new/tasks/view/screen/task_screen.dart';
import 'package:to_do_new/tasks/view/widget/bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [TaskScreen(), SettingScreen()];
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: EdgeInsets.zero,
        color: AppTheme.white,
        child: BottomNavigationBar(
            currentIndex: currentTabIndex,
            elevation: 0,
            onTap: (index) {
              currentTabIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          // isScrollControlled: true,
          builder: (_) => ButtonSheet(),
        ),
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
