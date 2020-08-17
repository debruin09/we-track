import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_track/blocs/forgotPasswordBloc/forgotpassword_bloc.dart';
import 'package:we_track/blocs/login_bloc/login_bloc.dart';
import 'package:we_track/blocs/login_bloc/login_event.dart';
import 'package:we_track/blocs/login_bloc/login_state.dart';
import 'package:we_track/repositories/user_repository.dart';
import 'package:we_track/screens/login/login_screen.dart';
import 'package:we_track/shared/themes.dart/themes.dart';
import 'package:we_track/utils/validators.dart';
import 'package:we_track/widgets/curved_widget.dart';
import 'package:we_track/widgets/gradient_button.dart';

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
      body: BlocProvider<ForgotpasswordBloc>(
        create: (context) =>
            ForgotpasswordBloc(userRepository: _userRepository),
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

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
      builder: (context, state) {
        if (state is ForgotpasswordInitial) {
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
                      BlocProvider.of<ForgotpasswordBloc>(context).add(
                          ForgotPasswordPressed(email: _emailController.text));
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
        } else if (state is LoadingForgotPasswordState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ForgotPasswordSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop();
          });
        } else if (state is ForgotPasswordFailure) {
          return Center(child: Text('${state.message}'));
        }
        return Container();
      },
    );
  }
}
