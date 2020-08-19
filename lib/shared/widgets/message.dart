import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String text;

  final bool me;
  final String userType;

  const Message({
    Key key,
    this.from,
    this.text,
    this.me,
    this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        padding: EdgeInsets.only(top: 5.0),
        child: Column(
          crossAxisAlignment:
              me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "$from",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Material(
              color: text != ""
                  ? me ? Colors.black : Colors.white
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: me
                      ? TextStyle(
                          color: Colors.white, fontFamily: "EraserDust-p70d")
                      : TextStyle(
                          color: Colors.black, fontFamily: "EraserDust-p70d"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
