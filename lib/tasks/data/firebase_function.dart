import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:to_do_new/tasks/view_model/task_model.dart';

class FirebaseFunction {
  static CollectionReference<TaskModel> getTasksColction() =>
      FirebaseFirestore.instance.collection('tesks').withConverter<TaskModel>(
            fromFirestore: (docSnapshot, _) =>
                TaskModel.formJeson(docSnapshot.data()!),
            toFirestore: (value, _) => value.toJeson(),
          );
  static Future<void> addTasksToFireStore(TaskModel task) async {
    CollectionReference<TaskModel> taskCollection = getTasksColction();
    DocumentReference<TaskModel> doc = taskCollection.doc();
    task.id = doc.id;
    doc.set(task);
    ;
  }

  static Future<List<TaskModel>> getAllTaskCollection() async {
    CollectionReference<TaskModel> taskCollection = getTasksColction();
    QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
    List<TaskModel> docs =
        querySnapshot.docs.map((doce) => doce.data()).toList();
    return docs;
  }

  static Future<void> deleteTaskForomFireStore(String taskId) async {
    CollectionReference<TaskModel> allcollection = getTasksColction();
    return allcollection.doc(taskId).delete();
  }

  static Future<void> editIsDone(
    TaskModel task,
  ) async {
    var collection = getTasksColction();
    return collection.doc(task.id).update({
      "isDone": task.isDone,
    });
  }

  static Future<void> editTask(
    TaskModel? task,
    // String uId
  ) async {
    var collection = getTasksColction();
    return collection.doc(task!.id).update(task!.toJeson());
  }
}
