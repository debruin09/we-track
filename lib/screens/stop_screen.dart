import 'package:flutter/material.dart';
import 'package:we_track/blocs/notificationBloc/notification_bloc.dart';
import 'package:we_track/injection.dart';
import 'package:we_track/models/notification.dart';
import 'package:we_track/shared/themes.dart/themes.dart';

/// This is the stop screen which will display when the driver clicks on a route
///
class StopScreen extends StatelessWidget {
  final String route;
  final notificationBloc = locator.get<NotificationBloc>();
  StopScreen({Key key, this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// This alert dialog shows when the driver clicks on the button to notify the student
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
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
          child: Container(
              height: 250.0,
              color: Colors.redAccent,
              child: ListView.separated(
                  separatorBuilder: (context, indedx) => Divider(
                        color: tertiaryColor,
                      ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Builder(
                      builder: (context) => MaterialButton(
                        height: 30.0,
                        onPressed: () {
                          notificationBloc.add(AddNotification(MyNotification(
                              alert: "Driver reaches stop: ${index + 1}",
                              id: "$route")));
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
                          "Stop ${index + 1}",
                          style: TextStyle(color: tertiaryColor),
                        ),
                      ),
                    );
                  })),
        ));
  }
}
