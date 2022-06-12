import 'package:connectivity/connectivity.dart';
import 'package:device_tracker/authentication_bloc/authentication_bloc.dart';
import 'package:device_tracker/authentication_bloc/authentication_event.dart';
import 'package:device_tracker/helper/device_inf.dart';
//import 'package:device_tracker/helper/device_inf.dart';
import 'package:device_tracker/login_system/login/bloc/login_bloc.dart';
import 'package:device_tracker/login_system/login/bloc/login_event.dart';
import 'package:device_tracker/login_system/login/bloc/login_state.dart';
import 'package:device_tracker/login_system/login/button/create_account_button.dart';
import 'package:device_tracker/login_system/login/button/login_button.dart';
import 'package:device_tracker/repository/user_repository.dart';
import 'package:device_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DeviceInfo deviceInfo = DeviceInfo();
  late LoginBloc _loginBloc;
  TextEditingController? controller;
  UserRepository get _userRepository => widget._userRepository;
  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    deviceInfo.getModel();
    super.initState();
    test();
    setState(() {
      test();
      controller = TextEditingController()..text = deviceInfo.android.toString();
    });
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  ///
   test() async{
    setState(() {
      controller = TextEditingController()..text = deviceInfo.android.toString();
    });
   }
  ///

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 80),
                  ),
                  TextFormField(
                    // controller: controller = TextEditingController()..text = deviceInfo.android.toString(),
                    controller: controller = TextEditingController()..text = deviceInfo.android.toString(),
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_box_rounded),
                      labelText: 'The name of your device has already been entered here',
                      //widget.androidName.toString(),
                      //deviceInfo.android.toString(),
                    ),
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.always,
                    ///
                    // validator: (_) {
                    //   return !state.isEmailValid ? 'Invalid User name' : null;
                    // },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off), onPressed: () { setState(() {
                          _isObscure = !_isObscure;
                        }); },
                      ),
                    ),
                    obscureText: _isObscure,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,

                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        LoginButton(
                          onPressed: isLoginButtonEnabled(state) ? _onFormSubmitted : null,
                        ),
                        CreateAccountButton(userRepository: _userRepository),
                      ],
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
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'You have not internet';
    final color = hasInternet ? Colors.green : Colors.red;
    Utils.showTopSnackBar(message, color);
  }
}