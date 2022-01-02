import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  final String poyload;
  const NotificationScreen({Key? key, required this.poyload}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payload = widget.poyload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back,
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        elevation: 0.0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          _payload.toString().split('|')[1],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                Text(
                  'hello, majdi',
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      color: Get.isDarkMode ? Colors.white : darkGreyClr),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'you have new reminder',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10 ),
                margin: const EdgeInsets.symmetric(horizontal: 30, ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: primaryClr,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.text_format,
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'title',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        _payload.toString().split('|')[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        _payload.toString().split('|')[1],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                       Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Time',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        _payload.toString().split('|')[2],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
