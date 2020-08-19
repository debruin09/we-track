import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_track/blocs/register_bloc/register_state.dart';
import 'package:we_track/repositories/user_repository.dart';
import 'package:we_track/utils/validators.dart';

import 'register_event.dart';

/// This is the registtation bloc that maps the register events to states
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterUsernameChanged) {
      yield* _mapRegisterUsernameChangeToState(event.username);
    } else if (event is RegisterTypeChanged) {
      yield* _mapRegisterTypeChangeToState(event.type);
    } else if (event is RegisterRouteChanged) {
      yield* _mapRegisterRouteChangeToState(event.route);
    } else if (event is RegisterStopChanged) {
      print("From bloc: ${event.stop}");
      yield* _mapRegisterStopChangeToState(event.stop);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          email: event.email,
          password: event.password,
          username: event.username,
          route: event.route,
          stop: event.stop,
          type: event.type);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterUsernameChangeToState(
      String username) async* {
    yield state.update(isUsernameValid: Validators.isValidUsername(username));
  }

  Stream<RegisterState> _mapRegisterTypeChangeToState(String type) async* {
    yield state.update(isTypeValid: Validators.isValidType(type));
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterStopChangeToState(String stop) async* {
    yield state.update(isStopValid: true);
  }

  Stream<RegisterState> _mapRegisterRouteChangeToState(String route) async* {
    yield state.update(isRouteValid: Validators.isValidRoute(route));
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      {String email,
      String password,
      String username,
      String type,
      String stop,
      String route}) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
          email: email,
          username: username,
          type: type,
          password: password,
          stop: stop,
          route: route);
      yield RegisterState.success();
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
