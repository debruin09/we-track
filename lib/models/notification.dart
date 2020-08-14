import 'package:cloud_firestore/cloud_firestore.dart';

class MyNotification {
  String alert;
  String id;
  MyNotification({
    this.alert,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'alert': alert,
      'id': id,
    };
  }

  factory MyNotification.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MyNotification(
      alert: map['alert'],
      id: map['id'],
    );
  }

  static MyNotification fromSnapshot(DocumentSnapshot snap) {
    return MyNotification(
      id: snap.documentID,
      alert: snap.data['alert'] ?? "",
    );
  }

  @override
  String toString() => 'MyNotification(alert: $alert, id: $id)';
}
