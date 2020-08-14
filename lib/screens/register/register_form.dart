import 'package:we_track/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_event.dart';
import 'package:we_track/blocs/register_bloc/register_bloc.dart';
import 'package:we_track/blocs/register_bloc/register_event.dart';
import 'package:we_track/blocs/register_bloc/register_state.dart';
import 'package:we_track/shared/themes.dart/themes.dart';
import 'package:we_track/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/register_bloc/register_event.dart';

/// This is the register form UI
class RegisterForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  /// Initializing text controllers that controls the input of the user
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _routeController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _usernameController.text.isNotEmpty &&
      _typeController.text.isNotEmpty &&
      _routeController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
    _usernameController.addListener(_onUsernameChange);
    _typeController.addListener(_onTypeChange);
    _routeController.addListener(_onRouteChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Register Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: primaryColor,
              ),
            );
        }

        if (state.isSubmitting) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registering...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: primaryColor,
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedIn(),
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Username",
                    ),
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isUsernameValid ? 'Invalid Username' : null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: "Password",
                    ),
                    obscureText: true,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  TextFormField(
                    controller: _typeController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.category),
                      labelText: "User Type",
                    ),
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isTypeValid ? 'Driver or Student' : null;
                    },
                  ),
                  TextFormField(
                    controller: _routeController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.track_changes),
                      labelText: "Route",
                    ),
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isRouteValid
                          ? 'Route 1, Route 2, Route 3, Route 4,'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    width: 150,
                    height: 45,
                    onPressed: () {
                      if (isButtonEnabled(state)) {
                        _onFormSubmitted();
                      }
                    },
                    text: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChanged(password: _passwordController.text));
  }

  void _onUsernameChange() {
    _registerBloc
        .add(RegisterUsernameChanged(username: _usernameController.text));
  }

  void _onRouteChange() {
    _registerBloc.add(RegisterRouteChanged(route: _routeController.text));
  }

  void _onTypeChange() {
    _registerBloc.add(RegisterTypeChanged(type: _typeController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(RegisterSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
        route: _routeController.text,
        username: _usernameController.text,
        type: _typeController.text));
  }
}
