import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_event.dart';
import 'package:we_track/blocs/notificationBloc/notification_bloc.dart';
import 'package:we_track/helpers/stop_helpers.dart';
import 'package:we_track/models/notification.dart';
import 'package:we_track/models/user.dart';
import 'package:we_track/screens/chat/chat_screen.dart';
import 'package:we_track/shared/themes.dart/themes.dart';
import 'package:we_track/widgets/gradient_button.dart';

import '../injection.dart';

/// This is the driver screen UI
class DriverMenuScreen extends StatefulWidget {
  final User user;

  const DriverMenuScreen({Key key, this.user}) : super(key: key);

  @override
  _DriverMenuScreenState createState() => _DriverMenuScreenState();
}

class _DriverMenuScreenState extends State<DriverMenuScreen> {
  /// This is the notification which will allow the student to listen if there is a notification
  final notificationBloc = locator.get<NotificationBloc>();

  @override
  void dispose() {
    notificationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> driverStops = List<String>();

    if (routes.containsKey(widget.user.route)) {
      routes[widget.user.route].forEach((element) {
        driverStops.add(element);
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Driver Menu",
          style: TextStyle(color: secondaryColor),
        ),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                /// This will allow the user to log out
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLoggedOut());
              },
              child: Text("Logout", style: TextStyle(color: secondaryColor)))
        ],
      ),
      body: ListView.separated(
          separatorBuilder: (comtext, index) => Divider(),
          itemCount: driverStops.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Container(
                color: secondaryColor,
                child: ListTile(
                  onTap: () {
                    notificationBloc.add(AddNotification(MyNotification(
                        route: widget.user.route,
                        date: DateTime.now().toIso8601String().toString(),
                        alert: "Driver reaches stop: ${driverStops[index]}",
                        id: "${driverStops[index]}")));
                    print("Made request");
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: primaryColor,
                      content: Text(
                        'Stop send successful',
                        style: TextStyle(color: secondaryColor),
                      ),
                      duration: Duration(seconds: 3),
                    ));
                  },
                  title: Text(
                    index == 0
                        ? "Departure: ${driverStops[index]}"
                        : "${index + 1}: ${driverStops[index]}",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: ChatButton(
        text: Text("Chat", style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        user: widget.user,
                      )));
        },
      ),
    );
  }
}
