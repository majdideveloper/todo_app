import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/pages/add_task_page.dart';
import 'package:todo_app/ui/pages/home_page.dart';
import 'package:todo_app/ui/pages/notification_screen.dart';
import 'package:todo_app/ui/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode:ThemeServices().theme ,
      home: const HomePage(),
    );
  }
}
