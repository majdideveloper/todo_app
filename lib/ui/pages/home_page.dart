import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    _taskController.getTask();
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
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.portrait
                  ? Axis.vertical
                  : Axis.horizontal,
              itemCount: _taskController.taskList.length,
              itemBuilder: (context, index) {
                var task = _taskController.taskList[index];
                if (task.repeat == 'Daily' ||
                    task.date == DateFormat.yMd().format(_selectedDate) ||
                    (task.repeat == 'Weekly' &&
                        _selectedDate
                                    .difference(
                                        DateFormat.yMd().parse(task.date!))
                                    .inDays %
                                7 ==
                            0) ||
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date!).day ==
                            _selectedDate.day)) {
                  var hour = task.startTime.toString().split(':')[0];

                  var date = DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat('hh:mm').format(date);
                  NotifyHelper().scheduledNotification(
                      int.parse(myTime.toString().split(':')[0]),
                      int.parse(myTime.toString().split(':')[1]),
                      task);
                  return AnimationConfiguration.staggeredList(
                    duration: Duration(milliseconds: 1500),
                    position: index,
                    child: SlideAnimation(
                      horizontalOffset: 500,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: Expanded(child: TaskTile(task)),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              });
        }
      }),
    );
    // return GestureDetector(
    //   onTap:(){
    //     _showBottomSheet(
    //     context,
    //     Task(
    //       id: 1,
    //       title: 'titel',
    //       note: 'note',
    //       isCompleted: 0,
    //       date: '',
    //       startTime: '',
    //       endTime: '',
    //       color: 0,
    //     )
    //   );
    //   } ,
    //   child: Expanded(
    //     child: TaskTile(
    //       Task(
    //         id: 1,
    //         title: 'titel',
    //         note: 'note',
    //         isCompleted: 0,
    //         date: '',
    //         startTime: '',
    //         endTime: '',
    //         color: 0,
    //       ),
    //     ),
    // Obx(() {

    //
    // }),
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(
            milliseconds: 5000,
          ),
          child: SingleChildScrollView(
            child: Center(
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
                    child: Text(
                      'Add Your First Task  ',
                      style: subTitleStyle,
                    ),
                  ),
                ],
              ),
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
        height: 100,
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
            height: 45,
              label: "+ Add Task",
              onTap: () async {
                await Get.to(AddTaskPage());
                _taskController.getTask();
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
        height: SizeConfig.screenHeight /
            2, //(SizeConfig.orientation == Orientation.landscape)
        // ? (task.isCompleted == 1
        //     ? SizeConfig.screenHeight * 0.6
        //     : SizeConfig.screenHeight * 0.8)
        // : (task.isCompleted == 1
        //     ? SizeConfig.screenHeight * 0.50
        //     : SizeConfig.screenHeight * 0.39),
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
                      NotifyHelper().cancelNotification(task);

                      _taskController.markIsCompletedTask(task);
                      Get.back();
                    },
                    clr: primaryClr,
                  ),
            Divider(),
            _buildBottomSheet(
              label: 'Delete Task',
              onTap: () {
                NotifyHelper().cancelNotification(task);
                _taskController.deleteTask(task);
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
