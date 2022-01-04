import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/notification_services.dart';
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
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOsPermission();
    notifyHelper.initializeNotification();
  }

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
    return GestureDetector(
      onTap:(){
        _showBottomSheet(
        context,
        Task(
          id: 1,
          title: 'titel',
          note: 'note',
          isCompleted: 0,
          date: '',
          startTime: '',
          endTime: '',
          color: 0,
        )
      );
      } ,
      child: Expanded(
        child: TaskTile(
          Task(
            id: 1,
            title: 'titel',
            note: 'note',
            isCompleted: 0,
            date: '',
            startTime: '',
            endTime: '',
            color: 0,
          ),
        ),
        // Obx(() {

        //   if(_taskController.taskList.isEmpty){
        //     return _noTaskMsg();

        //   }else{
        //    return Container();
        //   }
        // }),
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(
            milliseconds: 5000,
          ),
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              children: [
                SizeConfig.orientation == Orientation.landscape
                    ? SizedBox(
                        height: 5,
                      )
                    : SizedBox(
                        height: 200,
                      ),
                SvgPicture.asset(
                  'images/task.svg',
                  height: 90.0,
                  semanticsLabel: 'task',
                  color: primaryClr.withOpacity(0.5),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('data'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _addDateBar() {
    return Container(
      color: Colors.grey,
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

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(top: 4.0),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.30
                : SizeConfig.screenHeight * 0.39),
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Get.isDarkMode ? Colors.grey : Colors.grey[300],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            task.isCompleted == 1
                ? Container()
                : _buildBottomSheet(
                    label: 'Task Completed',
                    onTap: () {
                      Get.back();
                    },
                    clr: primaryClr,
                  ),
            Divider(),
            _buildBottomSheet(
              label: 'Delete Task',
              onTap: () {
                Get.back();
              },
              clr: primaryClr,
            ),
            Divider(),
            _buildBottomSheet(
              label: 'Cancel',
              onTap: () {
                Get.back();
              },
              clr: primaryClr,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }

  _buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20.0),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
