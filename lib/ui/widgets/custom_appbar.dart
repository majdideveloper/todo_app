import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/theme.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
   CustomAppbar({Key? key,this.visible}) : super(key: key);
  bool? visible ;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:visible == true? IconButton(
        onPressed: Get.back,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: primaryClr,
        ),
      ):Container(),
      elevation: 0.0,
      backgroundColor: context.theme.backgroundColor,
      actions: [
        IconButton(
          onPressed: () {
            print(Get.isDarkMode);
            ThemeServices().switchTheme();
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
