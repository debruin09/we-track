part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoadInProgress extends NotificationState {}

class NotificationLoadSuccess extends NotificationState {
  final List<MyNotification> notifications;

  NotificationLoadSuccess({@required this.notifications})
      : assert(notifications != null);
  @override
  List<Object> get props => [notifications];

  @override
  String toString() => 'NotificationLoadSuccess(requests: $notifications)';
}

class NotificationErrorState extends NotificationState {
  final String message;

  NotificationErrorState({@required this.message}) : assert(message != null);
  @override
  List<Object> get props => [message];
}
