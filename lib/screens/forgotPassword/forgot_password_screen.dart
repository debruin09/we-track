import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_track/blocs/forgotPasswordBloc/forgotpassword_bloc.dart';
import 'package:we_track/repositories/user_repository.dart';
import 'package:we_track/screens/forgotPassword/forgot_password_form.dart';
import 'package:we_track/shared/themes.dart/themes.dart';
import 'package:we_track/widgets/curved_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const ForgotPasswordScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<ForgotPasswordBloc>(
        create: (context) =>
            ForgotPasswordBloc(userRepository: _userRepository),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: tertiaryColor,
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                CurvedWidget(
                  child: Container(
                    padding: const EdgeInsets.only(top: 100, left: 50),
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                    ),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(fontSize: 40, color: primaryColor),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 230),
                    child: ForgotPasswordForm())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
