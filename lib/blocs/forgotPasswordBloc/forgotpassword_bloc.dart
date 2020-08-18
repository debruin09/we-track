import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:we_track/repositories/user_repository.dart';
import 'package:we_track/utils/validators.dart';

part 'forgotpassword_event.dart';
part 'forgotpassword_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserRepository _userRepository;

  ForgotPasswordBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(ForgotPasswordState.initial());

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is ForgotPasswordEmailChanged) {
      yield* _mapForgotPasswordEmailChangeState(event.email);
    } else if (event is ForgotPasswordSubmitted) {
      yield* _mapForgotPasswordSubmittedState(email: event.email);
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordEmailChangeState(
      String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<ForgotPasswordState> _mapForgotPasswordSubmittedState(
      {String email}) async* {
    yield ForgotPasswordState.loading();
    try {
      await _userRepository.resetPassword(email);
      yield ForgotPasswordState.success();
    } catch (error) {
      print(error);
      yield ForgotPasswordState.failure();
    }
  }
}
