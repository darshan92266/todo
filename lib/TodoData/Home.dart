import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/TodoData/InsertData.dart';
import 'package:todo/TodoData/insertBloc/insert_bloc.dart';
import 'package:todo/TodoData/todobloc/todo_bloc.dart';

class Home extends StatelessWidget {
   Home({super.key});

  TodoBloc todoBloc = TodoBloc()..add(TodoInitialEvent());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      bloc: todoBloc,
      listener: (context, state) {
        if (state is HomeToInstertNavigateState) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return InsertData(state.data);
            },
          ));
        }
      },
      listenWhen: (previous, current) => current is TodoActionState,
      buildWhen: (previous, current) => current is! TodoActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case TodoLoadingSuccessState:
            final sucessState = state as TodoLoadingSuccessState;

            return Scaffold(
              appBar: AppBar(
                title: Text("Tasks"),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: sucessState.data.length,
                      itemBuilder: (context, index) {
                        return (sucessState.data[index]['status'] == 'new')
                            ? ListTile(
                                trailing: Wrap(
                                  children: [
                                    Checkbox(
                                        onChanged: (value) {
                                          InsertBloc().add(UpdateDataEvent(
                                              sucessState.data[index]['id'],
                                              sucessState.data[index]['title'],
                                              sucessState.data[index]['time'],
                                              sucessState.data[index]['date'],
                                              'done'));

                                          if (sucessState.data[index]
                                                  ['status'] ==
                                              'done') {
                                            InsertBloc().add(UpdateDataEvent(
                                                sucessState.data[index]['id'],
                                                sucessState.data[index]
                                                    ['title'],
                                                sucessState.data[index]['time'],
                                                sucessState.data[index]['date'],
                                                'new'));
                                          }

                                          todoBloc.add(TodoInitialEvent());
                                        },
                                        value: sucessState.data[index]
                                                ['status'] ==
                                            'done'),
                                    IconButton(
                                        onPressed: () {
                                          todoBloc.add(DeleteTaskEvent(
                                              sucessState.data[index]['id']));
                                          todoBloc.add(TodoInitialEvent());
                                        },
                                        icon:
                                            Icon(Icons.delete_outline_outlined))
                                  ],
                                ),
                                onTap: () {
                                  todoBloc.add(HomeToInstertNavigateEvent(
                                      sucessState.data[index]));
                                },
                                leading: CircleAvatar(
                                    child: Text(
                                        "${sucessState.data[index]['time']}"),
                                    backgroundColor: Colors.white),
                                title: Text(
                                  "${sucessState.data[index]['title']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                                subtitle:
                                    Text("${sucessState.data[index]['date']}"),
                              )
                            : SizedBox();
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Done Tasks Lists"),
                        Expanded(
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            itemCount: sucessState.data.length,
                            itemBuilder: (context, index) {
                              return (sucessState.data[index]['status'] ==
                                      'done')
                                  ? ListTile(
                                      trailing: Checkbox(
                                          onChanged: (value) {
                                            print(value);
                                            InsertBloc().add(UpdateDataEvent(
                                                sucessState.data[index]['id'],
                                                sucessState.data[index]
                                                    ['title'],
                                                sucessState.data[index]['time'],
                                                sucessState.data[index]['date'],
                                                'done'));

                                            if (sucessState.data[index]
                                                    ['status'] ==
                                                'done') {
                                              InsertBloc().add(UpdateDataEvent(
                                                  sucessState.data[index]['id'],
                                                  sucessState.data[index]
                                                      ['title'],
                                                  sucessState.data[index]
                                                      ['time'],
                                                  sucessState.data[index]
                                                      ['date'],
                                                  'new'));
                                            }
                                            todoBloc.add(TodoInitialEvent());
                                          },
                                          value: sucessState.data[index]
                                                  ['status'] == 'done'),
                                      onTap: () {
                                        todoBloc.add(HomeToInstertNavigateEvent(
                                            sucessState.data[index]));
                                      },
                                      leading: CircleAvatar(
                                          child: Text(
                                              "${sucessState.data[index]['time']}"),
                                          backgroundColor: Colors.white),
                                      title: Text(
                                        "${sucessState.data[index]['title']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                      subtitle: Text(
                                          "${sucessState.data[index]['date']}"),
                                    )
                                  : SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    todoBloc.add(HomeToInstertNavigateEvent());
                    // todoBloc.add(SendNotification('Heelooo', 'Sgdsyjgfsyjhgcbhdvcb'));
                  },
                  child: Icon(Icons.add)),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
