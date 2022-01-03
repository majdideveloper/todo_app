import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';
import 'package:todo_app/ui/widgets/custom_appbar.dart';
import 'package:todo_app/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'none';
  List<String> _repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(visible: true,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Add Task',
                  style: headingStyle,
                ),
              ),
              InputField(
                title: 'Title',
                hint: 'enter your Title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'enter your note here',
                controller: _titleController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start time',
                      hint: _startTime,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Time ',
                      hint: _endTime,
                    ),
                  ),
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton<dynamic>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.blueGrey,
                  items: remindList
                      .map(
                        //<DropDownMenuItem<String>>
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            '$value',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      _selectedRemind = newvalue;
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 32.0,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                ),
              ),
              InputField(
                title: 'Repeat',
                hint: '$_selectedRepeat',
                widget: DropdownButton<dynamic>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.blueGrey,
                  items: _repeatList
                      .map(
                        //<DropDownMenuItem<String>>
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            '$value',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      _selectedRepeat = newvalue;
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 32.0,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paletteColor(),
                  SizedBox(
                    height: 10.0,
                  ),
                  MyButton(
                    label: 'Create Task',
                    onTap: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

 

  Column paletteColor() {
    return Column(
      children: [
        Text(
          'Color',
          style: subHeadingStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Wrap(
          children: List.generate(
              3,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        child: _selectedColor == index
                            ? Icon(
                                Icons.done,
                                size: 30,
                              )
                            : null,
                        backgroundColor: index == 0
                            ? primaryClr
                            : index == 1
                                ? pinkClr
                                : orangeClr,
                        radius: 14.0,
                      ),
                    ),
                  )),
        )
      ],
    );
  }
}
