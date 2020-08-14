import 'package:flutter/material.dart';
import 'package:we_track/blocs/notificationBloc/notification_bloc.dart';
import 'package:we_track/injection.dart';
import 'package:we_track/models/notification.dart';
import 'package:we_track/shared/themes.dart/themes.dart';

class StopScreen extends StatelessWidget {
  final String route;
  final notificationBloc = locator.get<NotificationBloc>();
  StopScreen({Key key, this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tertiaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            "Driver Menu",
            style: TextStyle(color: secondaryColor),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Container(
            color: Colors.redAccent,
            child: Builder(
              builder: (context) => ListTile(
                onTap: () {
                  notificationBloc.add(AddNotification(
                      MyNotification(alert: "Alert", id: "$route")));
                  print("Made request");
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: primaryColor,
                    content: Text('Stop send'),
                    duration: Duration(seconds: 3),
                  ));
                },
                title: Text(
                  "STOP",
                  style: TextStyle(color: tertiaryColor),
                ),
              ),
            ),
          ),
        ));
  }
}
