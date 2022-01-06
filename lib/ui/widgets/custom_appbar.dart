import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/widgets.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({Key? key, this.visible}) : super(key: key);
  bool? visible;
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: visible == true
          ? IconButton(
              onPressed: Get.back,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: primaryClr,
              ),
            )
          : Container(),
      elevation: 0.0,
      backgroundColor: context.theme.backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyButton(
            height: 30.0,
            label: 'Clear',
            onTap: () {
                NotifyHelper().cancelAllNotification();
              _taskController.deleteAllTask();
            
            },
          ),
        ),
        IconButton(
          onPressed: () {
            ThemeServices().switchTheme();
            // NotifyHelper().displayNotification(title: 'majdi', body: 'now',);
            // NotifyHelper().scheduledNotification();
          },
          icon: Icon(
            Icons.brightness_4_outlined,
            color: primaryClr,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
