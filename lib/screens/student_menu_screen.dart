import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_event.dart';
import 'package:we_track/blocs/notificationBloc/notification_bloc.dart';
import 'package:we_track/injection.dart';
import 'package:we_track/models/notification.dart';
import 'package:we_track/models/user.dart';
import 'package:we_track/repositories/local_notification_service.dart';
import 'package:we_track/shared/themes.dart/themes.dart';
import 'package:we_track/shared/widgets/shared_widgets.dart';

/// This is the student screen UI
class StudentMenuScreen extends StatefulWidget {
  final User user;

  StudentMenuScreen({Key key, this.user}) : super(key: key);

  @override
  _StudentMenuScreenState createState() => _StudentMenuScreenState();
}

class _StudentMenuScreenState extends State<StudentMenuScreen> {
  /// This is the notification which will allow the student to listen if there is a notification
  final notificationBloc = locator.get<NotificationBloc>();

  /// This will show a notification when there is one
  final localNotificationService = locator.get<LocalNotificationService>();

  /// This function will trigger a load notification which means
  /// that all students can now subscribe to a notification
  @override
  void initState() {
    notificationBloc.add(LoadNotification());
    super.initState();
    localNotificationService.initializing();
  }

  @override
  void dispose() {
    // notificationBloc.add(DeleteNotification(MyNotification(
    //     alert: "Driver reaches stop:", id: "${widget.user.route}")));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tertiaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            "Student Menu",
            style: TextStyle(color: secondaryColor),
          ),
          centerTitle: true,
          actions: [
            FlatButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLoggedOut());
                },
                child: Text("Logout", style: TextStyle(color: secondaryColor)))
          ],
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
            bloc: notificationBloc,
            builder: (context, state) {
              if (state is NotificationInitial) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: Text("${widget.user.route}",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                );
              } else if (state is NotificationLoadInProgress) {
                return Loading();
              } else if (state is NotificationLoadSuccess) {
                var x = state.notifications.map((e) => e).where((element) {
                  return element.route == widget.user.route;
                });

                List<MyNotification> notifications =
                    List<MyNotification>.from(x);

                List<DateTime> dates = [];
                notifications.forEach((e) {
                  dates.add(DateTime.parse(e.date));
                });

                var y = state.notifications.map((e) => e).where((element) {
                  return element.route == widget.user.route &&
                      element.date == dates.last.toIso8601String().toString();
                });

                List<MyNotification> d = List<MyNotification>.from(y);

                print("This is x: $notifications");
                if (y != null && x != null && d.isNotEmpty) {
                  localNotificationService.notification();
                  return Column(
                    children: [
                      Text("${widget.user.route}: ${widget.user.stop}",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: Container(
                          color: Colors.redAccent,
                          child: ListTile(
                            title: Text(
                              "${d.first.alert}" ?? 'no notification',
                              style: TextStyle(color: tertiaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is NotificationErrorState) {
                  return Center(child: Text("No notifications"));
                }
                return Center(child: Text("No notifications"));
              }
              return Container();
            }));
  }
}
