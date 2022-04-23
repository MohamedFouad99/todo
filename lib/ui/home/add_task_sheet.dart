// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';
import 'package:todo/ui/ui_utils.dart';

import '../../firebase_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  String title = '';
  String description = '';
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Task",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(color: Colors.black),
            ),
            Form(
                key: formController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      minLines: 4,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'description',
                      ),
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter task description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text('Task Date'),
                    SizedBox(
                      height: 8,
                    ),
                    InkWell(
                        onTap: () {
                          chooseDate();
                        },
                        child: Text(
                          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text('Add Task'))
          ],
        ),
      ),
    );
  }

// how to format date time
  void chooseDate() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formController.currentState?.validate() == true) {
      // insert task
      //now have: title,desc
      Task task = Task(
          title: title,
          description: description,
          date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
      showLoading(context, 'loading...', isCancelable: false);
      addTaskToFireStore(task).then((value) {
        hideDialoge(context);
        showMessage(context, 'Task was added successfully', 'ok', () {
          Navigator.pop(context);
          Navigator.pop(context);
        }, isCanclelable: false);
      }).catchError((onError) {
        hideDialoge(context);
        showMessage(context, 'some thing went wrong. try again later', 'ok',
            () {
          Navigator.pop(context);
        });
      });
    }
  }
}
