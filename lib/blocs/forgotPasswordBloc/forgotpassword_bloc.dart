import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:we_track/repositories/user_repository.dart';

part 'forgotpassword_event.dart';
part 'forgotpassword_state.dart';

class ForgotpasswordBloc
    extends Bloc<ForgotpasswordEvent, ForgotpasswordState> {
  final UserRepository _userRepository;

  ForgotpasswordBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(ForgotpasswordInitial());

  @override
  Stream<ForgotpasswordState> mapEventToState(
    ForgotpasswordEvent event,
  ) async* {
    if (event is ForgotPasswordPressed) {
      yield* _mapForgotPasswordPressedToState(email: event.email);
    }
  }

  Stream<ForgotpasswordState> _mapForgotPasswordPressedToState(
      {String email}) async* {
    yield LoadingForgotPasswordState();
    try {
      await _userRepository.resetPassword(email);
      yield ForgotPasswordSuccess();
    } catch (e) {
      yield ForgotPasswordFailure(message: e.toString());
    }
  }
}
