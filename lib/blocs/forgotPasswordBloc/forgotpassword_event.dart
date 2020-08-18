part of 'forgotpassword_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordSubmitted({@required this.email});

  @override
  List<Object> get props => [email];
}
