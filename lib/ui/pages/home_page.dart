import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/pages/add_task_page.dart';
import 'package:todo_app/ui/size_config.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppbar(
        visible: false,
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            _addTaskBar(),
             SizedBox(
              height: 20,
            ),
            _addDateBar(),
            SizedBox(
              height: 20,
            ),
            _showTasks(),
          ],
        )),
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: _noTaskMsg(),
      // Obx(() {

      //   if(_taskController.taskList.isEmpty){
      //     return _noTaskMsg();

      //   }else{
      //    return Container();
      //   }
      // }),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('data'),
              ),
            ],
          ),
        )
      ],
    );
  }

  _addDateBar() {
    return Container(
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: 80,
        height: 80,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: headingStyle,
              )
            ],
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(AddTaskPage());
                _taskController.getTask;
              })
        ],
      ),
    );
  }
}
