import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_event.dart';
import 'package:we_track/blocs/notificationBloc/notification_bloc.dart';
import 'package:we_track/models/user.dart';
import 'package:we_track/screens/stop_screen.dart';
import 'package:we_track/shared/themes.dart/themes.dart';

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
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Container(
                color: secondaryColor,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StopScreen(route: "route ${index + 1}")));
                  },
                  title: Text(
                    "Route ${index + 1}",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
