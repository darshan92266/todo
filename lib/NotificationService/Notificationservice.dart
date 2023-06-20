import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo/TodoData/todobloc/todo_bloc.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('log');

  initializationNotification() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  sendNotification(String title, String body) async {
    var dateTime = DateTime(2000);
    List<Map> data=[];
    String qur = "select * from tasks";
    await TodoBloc.database!.rawQuery(qur).then((value) {
      data = value;
    });

    String date="${data[0]['date']} ${data[0]['time']}";
    print(date);

     var dateTime1 = DateTime(2000,1,1,1).toString();
     print(dateTime1);
     var datetime2 = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(date));

     var datt=DateTime.parse(datetime2);
     print(datt.runtimeType);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
            priority: Priority.high, importance: Importance.max);

    tz.initializeTimeZones();

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
        tz.TZDateTime.from(datt, tz.local), notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time).then((value) {
          print("Doneee");
    });
  }
}
