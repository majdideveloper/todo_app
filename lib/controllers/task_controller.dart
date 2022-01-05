import 'package:get/get.dart';
import 'package:todo_app/db/db_helper.dart';

import 'package:todo_app/models/task.dart';

class TaskController extends GetxController {
   RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({ required Task task}) {
    return DBHelper.insertInDB(task);
  }
 Future<void> getTask()async {
   List<Map<String, dynamic>> tasks= await DBHelper.queryFromDB();
   taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
   
  }
  void deleteTask(Task task)async {
   
  await DBHelper.deleteFromDB(task);
  getTask();
  }
 void  markIsCompletedTask(Task task)async {
  await DBHelper.updateInDB(task);
  getTask();
  }
}
