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
    Future _showAlertBox(context) async {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text("Notification has been send"),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    label: Text("cancel"))
              ],
            );
          });
    }

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
              builder: (context) => MaterialButton(
                onPressed: () {
                  notificationBloc.add(AddNotification(MyNotification(
                      alert: "Driver reaches stop: $route", id: "$route")));
                  print("Made request");
                  _showAlertBox(context);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: primaryColor,
                    content: Text(
                      'Stop send successful',
                      style: TextStyle(color: secondaryColor),
                    ),
                    duration: Duration(seconds: 3),
                  ));
                },
                minWidth: double.infinity,
                child: Text(
                  "Stop Notification",
                  style: TextStyle(color: tertiaryColor),
                ),
              ),
            ),
          ),
        ));
  }
}
