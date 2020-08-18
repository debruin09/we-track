part of 'forgotpassword_bloc.dart';

class ForgotPasswordState {
  final bool isEmailValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  ForgotPasswordState({
    this.isEmailValid,
    this.isSubmitting,
    this.isFailure,
    this.isSuccess,
  });

  bool get isFormValid => isEmailValid;

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
        isEmailValid: true,
        isSubmitting: false,
        isFailure: false,
        isSuccess: false);
  }

  factory ForgotPasswordState.loading() {
    return ForgotPasswordState(
      isEmailValid: true,
      isFailure: false,
      isSubmitting: true,
      isSuccess: false,
    );
  }
  factory ForgotPasswordState.failure() {
    return ForgotPasswordState(
      isEmailValid: true,
      isFailure: true,
      isSubmitting: false,
      isSuccess: false,
    );
  }
  factory ForgotPasswordState.success() {
    return ForgotPasswordState(
      isEmailValid: true,
      isFailure: false,
      isSubmitting: false,
      isSuccess: true,
    );
  }

  ForgotPasswordState update({
    bool isEmailValid,
  }) {
    return copyWith(
      isEmailValid: true,
      isFailure: false,
      isSubmitting: false,
      isSuccess: false,
    );
  }

  ForgotPasswordState copyWith({
    bool isEmailValid,
    bool isSuccess,
    bool isFailure,
    bool isSubmitting,
  }) {
    return ForgotPasswordState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
