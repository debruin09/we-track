import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_track/models/chat.dart';
import 'package:we_track/models/notification.dart';
import 'package:we_track/models/user.dart';

class FirestoreService {
  final userCollection = Firestore.instance.collection("users");
  final notificationCollection = Firestore.instance.collection("notification");
  final chatCollection = Firestore.instance.collection("messages");
  final String uid;
  FirestoreService({this.uid});

  /// When a users is registered their data will be added to the users
  /// collection in the database
  Future updateUserData({
    String uid,
    String username,
    String stop,
    String route,
    String email,
    String password,
    String type,
  }) async {
    return await userCollection.document(uid).setData({
      "uid": uid,
      "password": password,
      "username": username,
      "stop": stop,
      "route": route.toLowerCase(),
      "email": email,
      "type": type,
    });
  }

  /// When the driver press on the notification button this function w
  /// ill trigger and then add the notification to the database.
  /// The student will then subscribe to the notification and receive it.
  Future<void> addNotification(MyNotification notification) async {
    return await notificationCollection
        .document(notification.id)
        .setData(notification.toMap());
  }

  /// When the student already received the notification it will then be deleted from the database.
  Future<void> deleteNotification(MyNotification notification) async {
    return await notificationCollection.document(notification.id).delete();
  }

  /// This Stream allows the students to listen for any changes in the database and once
  /// it detects a change it will then receive that data from the database
  Stream<List<MyNotification>> notifications() {
    try {
      return notificationCollection.orderBy("date").snapshots().map((snapshot) {
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

  /// When a user is created in the database
  /// all this does is fetch that users data from that database
  Future getUser(String uid) async {
    try {
      final userData = await userCollection.document(uid).get();
      return User.fromMap(userData.data);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Stream<List<Chat>> chats() {
    try {
      return chatCollection.orderBy("date").snapshots().map(
          (q) => q.documents.map((doc) => Chat.fromSnapShot(doc)).toList());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> newChat(Chat chat) async {
    chatCollection.add(chat.toMap());
  }
}
