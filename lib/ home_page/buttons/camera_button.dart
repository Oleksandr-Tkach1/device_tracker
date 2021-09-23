import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  final VoidCallback? _onPressed;

  CameraButton({Key? key, VoidCallback? onPressed}): _onPressed = onPressed, super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      shape: CircleBorder(),
      padding: EdgeInsets.all(7),
      onPressed: () => {},
      child: Icon(Icons.camera_alt_outlined, size: 30, color: Colors.white,),
    );
  }
}