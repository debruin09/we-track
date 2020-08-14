import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;

  RegisterUsernameChanged({this.username});

  @override
  List<Object> get props => [username];
}

class RegisterTypeChanged extends RegisterEvent {
  final String type;

  RegisterTypeChanged({this.type});

  @override
  List<Object> get props => [type];
}

class RegisterRouteChanged extends RegisterEvent {
  final String route;

  RegisterRouteChanged({this.route});

  @override
  List<Object> get props => [route];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;
  final String username;
  final String type;
  final String route;

  RegisterSubmitted(
      {this.email, this.password, this.username, this.type, this.route});

  @override
  List<Object> get props => [email, password, username, type, route];
}
