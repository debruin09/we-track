class RegisterState {
  final bool isEmailValid;
  final bool isUsernameValid;
  final bool isTypeValid;
  final bool isRouteValid;
  final bool isStopValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isEmailValid && isPasswordValid && isUsernameValid && isTypeValid ||
      isRouteValid ||
      isStopValid;

  RegisterState(
      {this.isEmailValid,
      this.isRouteValid,
      this.isUsernameValid,
      this.isStopValid,
      this.isTypeValid,
      this.isPasswordValid,
      this.isSubmitting,
      this.isSuccess,
      this.isFailure});

  factory RegisterState.initial() {
    return RegisterState(
      isEmailValid: true,
      isUsernameValid: true,
      isTypeValid: true,
      isStopValid: true,
      isRouteValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isUsernameValid: true,
      isRouteValid: true,
      isTypeValid: true,
      isStopValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isEmailValid: true,
      isUsernameValid: true,
      isRouteValid: true,
      isStopValid: true,
      isTypeValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      isUsernameValid: true,
      isRouteValid: true,
      isStopValid: true,
      isTypeValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isEmailValid,
    bool isUsernameValid,
    bool isRouteValid,
    bool isStopValid,
    bool isTypeValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isUsernameValid: isUsernameValid,
      isTypeValid: isTypeValid,
      isStopValid: isStopValid,
      isRouteValid: isRouteValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isUsernameValid,
    bool isRouteValid,
    bool isTypeValid,
    bool isStopValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isTypeValid: isTypeValid ?? this.isTypeValid,
      isRouteValid: isRouteValid ?? this.isRouteValid,
      isStopValid: isStopValid ?? this.isStopValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
