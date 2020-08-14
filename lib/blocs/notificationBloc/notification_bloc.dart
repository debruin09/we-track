import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/foundation.dart';
import 'package:we_track/models/notification.dart';
import 'package:we_track/repositories/firestore_service.dart';

part 'notification_event.dart';
part 'notification_state.dart';

/// This is the notification bloc that maps incoming notifications events to states
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(this.databaseRepository) : super(NotificationInitial());
  final FirestoreService databaseRepository;
  StreamSubscription _notificationSubscription;

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is LoadNotification) {
      yield* _mapLoadNotificationToState();
    } else if (event is NotificationUpdated) {
      yield* _mapNotificationUpdateToState(event);
    } else if (event is AddNotification) {
      yield* _mapAddNotificationToState(event);
    } else if (event is DeleteNotification) {
      yield* _mapDeleteNotificationToState(event);
    }
  }

  Stream<NotificationState> _mapNotificationUpdateToState(
      NotificationUpdated event) async* {
    try {
      yield NotificationLoadSuccess(notifications: event.notifications);
    } catch (e) {
      yield NotificationErrorState(message: e.toString());
    }
  }

  Stream<NotificationState> _mapLoadNotificationToState() async* {
    _notificationSubscription?.cancel();
    _notificationSubscription = databaseRepository.notifications().listen(
      (notifications) {
        add(NotificationUpdated(notifications));
      },
    );
  }

  Stream<NotificationState> _mapAddNotificationToState(
      AddNotification event) async* {
    databaseRepository.addNotification(event.notification);
  }

  Stream<NotificationState> _mapDeleteNotificationToState(
      DeleteNotification event) async* {
    databaseRepository.deleteNotification(event.notification);
  }
}
