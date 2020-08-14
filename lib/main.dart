import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_state.dart';
import 'package:we_track/blocs/simple_bloc_observer.dart';
import 'package:we_track/injection.dart';
import 'package:we_track/repositories/user_repository.dart';
import 'package:we_track/screens/driver_menu_screen.dart';
import 'package:we_track/screens/landing_screen.dart';
import 'package:we_track/screens/login/login_screen.dart';
import 'package:we_track/screens/student_menu_screen.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/authentication_bloc/authentication_event.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();

  setupLocator();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AuthenticationStarted()),
      child: MyApp(
        userRepository: userRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff6a515e),
        cursorColor: Color(0xff6a515e),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }

          if (state is AuthenticationSuccess) {
            if (state.user.type == "student") {
              return StudentMenuScreen(user: state.user);
            } else {
              return DriverMenuScreen(
                user: state.user,
              );
            }
          }

          return LandingScreen();
        },
      ),
    );
  }
}