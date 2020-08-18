import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:we_track/blocs/authentication_bloc/authentication_event.dart';
import 'package:we_track/blocs/forgotPasswordBloc/forgotpassword_bloc.dart';
import 'package:we_track/shared/themes.dart/themes.dart';
import 'package:we_track/utils/validators.dart';
import 'package:we_track/widgets/gradient_button.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _emailController = TextEditingController();

  bool get isPopulated => _emailController.text.isNotEmpty;

  bool isButtonEnabled(ForgotPasswordState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  ForgotPasswordBloc _forgotPasswordBloc;

  @override
  void initState() {
    super.initState();
    _forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    _emailController.addListener(_onEmailChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Failed Sending email...'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
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
                    Text('Resetting Password...'),
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
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationStarted());
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (email) {
                      return !Validators.isValidEmail(email)
                          ? 'Invalid Email'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 10,
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
                      'Send email',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  void _onEmailChange() {
    _forgotPasswordBloc
        .add(ForgotPasswordEmailChanged(email: _emailController.text));
  }

  void _onFormSubmitted() {
    _forgotPasswordBloc.add(ForgotPasswordSubmitted(
      email: _emailController.text,
    ));
  }
}
