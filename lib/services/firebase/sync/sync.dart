import 'package:flutter/foundation.dart';
import 'package:unitaskpro/model/list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 

@immutable
final class Syncer {
  static final firestore = FirebaseFirestore.instance;
  static Future<void> syncList(Map<dynamic, ListModel> data) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    // var docRef = firestore
    //     .collection('root')
    //     .doc(FirebaseAuth.instance.currentUser!.uid);
    // final DocumentSnapshot docSnapshot = await docRef.get();

    if (currentUser != null) {
      WriteBatch batch = firestore.batch();

      data.forEach((key, listModel) {
        final DocumentReference docRef = firestore
            .collection('root')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('ListModel')
            .doc(key.toString());

        batch.set(docRef, {
          'title': listModel.title,
          'icon': listModel.icon,
          'description': listModel.description,
          'createdAt': listModel.createdAt,
          'updatedAt': listModel.updatedAt,
          'tasks': listModel.tasks
              .map((task) => {
                    'title': task.title,
                    'description': task.description,
                    'startedAt': task.startedAt,
                    'finishedAt': task.finishedAt,
                    'createdAt': task.createdAt,
                    'updatedAt': task.updatedAt,
                    'isStar': task.isStar,
                    'isDone': task.isDone,
                    'id': task.id,
                    'img': task.img,
                    'isMyDay': task.isMyDay,
                  })
              .toList(),
        });
      });

      await batch.commit();
    }
  }

  static Future<void> deleteListModel(dynamic key) async {
    final DocumentReference docRef = firestore
        .collection('root')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('ListModel')
        .doc(key.toString());
    await docRef.delete();
  }
}
