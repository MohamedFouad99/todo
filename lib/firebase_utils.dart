import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';

CollectionReference<Task> getTasksCollection() {
  var typedCollection = FirebaseFirestore.instance
      .collection('tasks')
      .withConverter<Task>(
          fromFirestore: ((snapshot, options) =>
              Task.fromJson(snapshot.data()!)),
          toFirestore: (task, options) => task.toJson());
  return typedCollection;
}

Future<void> addTaskToFireStore(Task task) {
  var collection = getTasksCollection();
  var docRef = collection.doc();
  task.id = docRef.id;
  return docRef.set(task);
}

Future<QuerySnapshot<Task>> getTasks(DateTime dateTime) {
  return getTasksCollection()
      .where('date',
          isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
      .get();
}

Stream<QuerySnapshot<Task>> listenForTask(DateTime dateTime) {
  return getTasksCollection()
      .where('date',
          isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
      .snapshots();
}

void deleteTaskFromFireStore(Task task) {
  getTasksCollection().doc(task.id).delete();
}

// void editTaskFromFireStore(Task task) {
//   getTasksCollection()
//       .doc(task.id)
//       .update({'title': task.title, 'description': task.description});
// }
