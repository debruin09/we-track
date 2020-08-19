import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String me;
  String from;
  String text;
  String date = DateTime.now().toIso8601String().toString();
  Chat({
    this.me,
    this.from,
    this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'text': text,
      'date': date,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Chat(
      me: map['me'],
      from: map['from'],
      text: map['text'],
    );
  }

  static Chat fromSnapShot(DocumentSnapshot doc) {
    return Chat(
      me: doc.data["me"],
      text: doc.data["text"],
      from: doc.data["from"],
    );
  }
}
