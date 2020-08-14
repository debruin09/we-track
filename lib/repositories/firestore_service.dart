import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_track/models/notification.dart';
import 'package:we_track/models/user.dart';

class FirestoreService {
  final requestCollection = Firestore.instance.collection("requests");
  // final alertCollection = Firestore.instance.collection("alerts");
  final userCollection = Firestore.instance.collection("users");
  final notificationCollection = Firestore.instance.collection("alerts");
  final String uid;
  FirestoreService({this.uid});

  // updates members fdata in the database
  Future updateUserData({
    String uid,
    String username,
    String route,
    String email,
    String password,
    String type,
  }) async {
    return await userCollection.document(uid).setData({
      "uid": uid,
      "password": password,
      "username": username,
      "route": route,
      "email": email,
      "type": type,
    });
  }

  Future<void> addNotification(MyNotification notification) async {
    print("Added : $notification");
    return await notificationCollection
        .document(notification.id)
        .setData(notification.toMap());
  }

  Future<void> deleteNotification(MyNotification notification) async {
    return await notificationCollection.document(notification.id).delete();
  }

  Stream<List<MyNotification>> notifications() {
    try {
      return notificationCollection.snapshots().map((snapshot) {
        return snapshot.documents
            .map((doc) => MyNotification.fromSnapshot(doc))
            .toList();
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future createUser(User user) async {
    try {
      await userCollection.document(user.uid).setData(user.toMap());
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  @override
  Future getUser(String uid) async {
    try {
      final userData = await userCollection.document(uid).get();
      return User.fromMap(userData.data);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
