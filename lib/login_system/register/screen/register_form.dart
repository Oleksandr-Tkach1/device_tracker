import 'package:device_tracker/authentication_bloc/authentication_bloc.dart';
import 'package:device_tracker/authentication_bloc/authentication_event.dart';
import 'package:device_tracker/helper/database.dart';
import 'package:device_tracker/helper/device_inf.dart';
import 'package:device_tracker/login_system/register/bloc/register_bloc.dart';
import 'package:device_tracker/login_system/register/bloc/register_event.dart';
import 'package:device_tracker/login_system/register/bloc/register_state.dart';
import 'package:device_tracker/login_system/register/button/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_tracker/helper/helper_functions.dart';

class RegisterForm extends StatefulWidget {
  final String? deviceName;

  RegisterForm({this.deviceName});

  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  DeviceInfo deviceInfo = DeviceInfo();
  ///
  late TextEditingController controller = TextEditingController()..text;
  ///
  //final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late RegisterBloc _registerBloc;
  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }
  DatabaseMethods databaseMethods = DatabaseMethods();

    @override
    void initState() {
      super.initState();
      //test();
      deviceInfo.getModel();
      _registerBloc = BlocProvider.of<RegisterBloc>(context);
      _emailController.addListener(_onEmailChanged);
      _passwordController.addListener(_onPasswordChanged);
    }

  signMeUP()  {
    if (_emailController.text != null) {
      Map<String, String> userInfoMap = {
        'name' : controller.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      databaseMethods.uploadUserInfo(userInfoMap);
    }
    else {
      print("Failure email");
    }
    HelperFunctions.saveUserNameSharedPreference(controller.text);
    HelperFunctions.saveUserEmailSharedPreference(_emailController.text);
  }


  @override
    Widget build(BuildContext context) {
      return BlocListener(
        bloc: _registerBloc,
        listener: (BuildContext context, RegisterState state) {
          if (state.isSubmitting) {
            Scaffold.of(context)
            //..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Registering...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
          if (state.isSuccess) {
            ///
            signMeUP();
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            Navigator.of(context).pop();
          }
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Registration Failure'),
                      Icon(Icons.error),
                    ],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: BlocBuilder(
          bloc: _registerBloc,
          builder: (BuildContext context, RegisterState state) {
            return Padding(
              padding: EdgeInsets.only(top: 180, left: 20, right: 20,),
              child: Form(
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(8),
                      ],
                      controller:
                      controller = TextEditingController()..text = deviceInfo.android.toString(),
                      //controller = TextEditingController()..text = widget.deviceName.toString(),
                      //controller = TextEditingController()..text = deviceInfo.android.toString(),
                      //controller,
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_box_rounded),
                        labelText: 'The name of your device has already been entered here',
                      ),
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return controller == null ? 'Invalid User name' : null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                    SizedBox(height: 18),
                    RegisterButton(
                      onPressed: isRegisterButtonEnabled(state) ? _onFormSubmitted : null,
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
      _registerBloc.add(
        EmailChanged(email: _emailController.text),
      );
    }

    void _onPasswordChanged() {
      _registerBloc.add(
        PasswordChanged(password: _passwordController.text),
      );
    }

    void _onFormSubmitted() {
      _registerBloc.add(
        Submitted(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }