// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/firebase_utils.dart';

import 'package:todo/model/task.dart';

import 'package:todo/ui/home/my_theme.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool taskDone = false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        extentRatio: .25,
        children: [
          SlidableAction(
            onPressed: (buildContext) {
              deleteTaskFromFireStore(widget.task);
            },
            label: 'Delete',
            backgroundColor: Theme.of(context).colorScheme.error,
            icon: Icons.delete,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                color: taskDone
                    ? MyThemeData.colorGreen
                    : Theme.of(context).primaryColor,
                width: 2,
                height: 80,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.title,
                        style: taskDone
                            ? Theme.of(context).textTheme.subtitle2
                            : Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.description,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  taskDone = true;
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: taskDone
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: taskDone
                      ? Text(
                          'Done!',
                          style: TextStyle(
                              color: MyThemeData.colorGreen,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      : Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
