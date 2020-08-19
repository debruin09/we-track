import 'package:cloud_firestore/cloud_firestore.dart';

/// This is just the Notification model class
class MyNotification {
  String alert;
  String id;
  String date;
  String route;
  MyNotification({
    this.alert,
    this.id,
    this.date,
    this.route,
  });

  Map<String, dynamic> toMap() {
    return {'alert': alert, 'id': id, 'date': date, 'route': route};
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
        date: snap.data["date"],
        id: snap.documentID,
        alert: snap.data['alert'] ?? "",
        route: snap.data['route']);
  }

  @override
  String toString() => 'MyNotification(alert: $alert, id: $id)';
}
