import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/size_config.dart';
import 'package:todo_app/ui/theme.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: SizeConfig.orientation == Orientation.landscape
          ? EdgeInsets.all(getProportionateScreenWidth(4.0))
          : EdgeInsets.all(getProportionateScreenWidth(8.0)),
          width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 2
            : SizeConfig.screenWidth,
            
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task.color),
        ),

        child: Row(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title!,
                     style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              
                              color: Colors.white,
                            ),
                          )
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('${task.startTime} - ${task.endTime}',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(task.note!,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(task.isCompleted == 0 ? 'TODO' : 'Completed',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0 :
      return primaryClr;
      case 1 :
      return orangeClr;
      case 2 :
      return pinkClr;
      default:
      return primaryClr;
    }
  }
}
