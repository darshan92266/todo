import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/NotificationService/Notificationservice.dart';
import 'package:todo/TodoData/Home.dart';
import 'package:todo/TodoData/insertBloc/insert_bloc.dart';

class InsertData extends StatefulWidget {
  Map? data;

  InsertData(this.data);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  InsertBloc insertBloc = InsertBloc();


  int? id;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();

  @override
  void initState() {
    if (widget.data != null) {
      titlecontroller.text = widget.data!['title'];
      timecontroller.text = widget.data!['time'];
      datecontroller.text = widget.data!['date'];
      id = widget.data!['id'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(">>>>>${widget.data}");
    return BlocConsumer<InsertBloc, InsertState>(
      bloc: insertBloc,
      listenWhen: (previous, current) => current is InsertActionState,
      buildWhen: (previous, current) => current is! InsertActionState,
      listener: (context, state) {
        if (state is InsertedSucessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: (widget.data != null)
                ? Text("Update successfully")
                : Text("Insert successfully"),
          ));
        } else if (state is InsertToHomeNavigateState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Are you sure?"),
                        content: Text("Quit without saving?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                //Navigator.po(context);
                              },
                              child: Text("Cancle")),
                          TextButton(
                              onPressed: () {
                                insertBloc.add(InsertToHomeNavigate());
                              },
                              child: Text("Yes"))
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.arrow_back)),
            title: Text("New Task"),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Enter Task")),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: datecontroller,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2030-05-13'),
                    ).then((value) {
                      datecontroller.text = DateFormat('yyyy-MM-dd').format(value!);
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Enter Date")),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: timecontroller,
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      timecontroller.text = value!.format(context).toString();
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Enter Time")),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                String title = titlecontroller.text;
                String date = datecontroller.text;
                String time = timecontroller.text;

                if (widget.data == null) {
                  insertBloc.add(InsterDataEvent(title, date, time, 'new'));
                  insertBloc.add(InsertToHomeNavigate());
                } else {
                  insertBloc
                      .add(UpdateDataEvent(id!, title, date, time, 'new'));
                  insertBloc.add(InsertToHomeNavigate());
                }
              },
              child: Icon(Icons.done)),
        );
      },
    );
  }
}

Widget DialogBox(BuildContext context) {
  InsertBloc insertBloc = InsertBloc();

  return AlertDialog(
    title: Text("Are you sure?"),
    content: Text("Quit without saving?"),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancle")),
      TextButton(
          onPressed: () {
            insertBloc.add(InsertToHomeNavigate());
            /* Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return Home();
              },
            ));*/
          },
          child: Text("Yes"))
    ],
  );
}
