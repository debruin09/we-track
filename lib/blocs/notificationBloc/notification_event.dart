part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadNotification extends NotificationEvent {
  @override
  List<Object> get props => [];
}

class NotificationUpdated extends NotificationEvent {
  final List<MyNotification> notifications;

  NotificationUpdated(this.notifications);
  @override
  List<Object> get props => [notifications];
}

class DeleteNotification extends NotificationEvent {
  final MyNotification notification;

  DeleteNotification(this.notification);
  @override
  List<Object> get props => [notification];
}

class AddNotification extends NotificationEvent {
  final MyNotification notification;

  AddNotification(this.notification);
  @override
  List<Object> get props => [notification];
}
