import 'package:device_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? _onPressed;

  //var result;

  LoginButton({Key? key, VoidCallback? onPressed}): _onPressed = onPressed, super(key: key);

  @override
  Widget build(BuildContext context) {
    //onPres();
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed:
        _onPressed,
      child: Text('Login'),
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
   onPres()async{
    final result = await Connectivity().checkConnectivity();
    showConnectivitySnackBar(result);
  }
}