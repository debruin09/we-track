part of 'forgotpassword_bloc.dart';

abstract class ForgotpasswordState extends Equatable {
  const ForgotpasswordState();

  @override
  List<Object> get props => [];
}

class ForgotpasswordInitial extends ForgotpasswordState {}

class LoadingForgotPasswordState extends ForgotpasswordState {}

class ForgotPasswordSuccess extends ForgotpasswordState {}

class ForgotPasswordFailure extends ForgotpasswordState {
  final String message;

  ForgotPasswordFailure({this.message});
}
