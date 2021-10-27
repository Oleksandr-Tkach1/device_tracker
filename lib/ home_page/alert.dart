import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AlertDialog locationRequest(BuildContext context, TextEditingController userPostComment) {
  final formKey = GlobalKey<FormState>();
  return AlertDialog(
    backgroundColor: Colors.white,
    title: Text('Choose how you want to add a photo?', style: TextStyle(color: Colors.black,)),
    // content: Container(
    //   child: SingleChildScrollView(
    //     child: Row(
    //       children: <Widget>[
    //         //SizedBox(width: 25),
    //         // GestureDetector(
    //         //   onTap: (){
    //         //     pickImagePhoto();
    //         //   },
    //         //   child: Container(
    //         //     width: 70,
    //         //     height: 70,
    //         //     child: Icon(Icons.add_a_photo, color: Colors.white, size: 32,),
    //         //     decoration: BoxDecoration(
    //         //       gradient: LinearGradient(colors: [
    //         //         const Color(0xff6495ed),
    //         //         const Color(0xff1e90ff),
    //         //         const Color(0xff00bfff),
    //         //       ]),
    //         //       borderRadius: BorderRadius.circular(40),
    //         //     ),
    //         //   ),
    //         // ),
    //         //SizedBox(width: 85),
    //         // GestureDetector(
    //         //   onTap: (){
    //         //     pickImage();
    //         //   },
    //         //   child: Container(
    //         //     width: 70,
    //         //     height: 70,
    //         //     child: Icon(Icons.image, color: Colors.white, size: 32,),
    //         //     decoration: BoxDecoration(
    //         //       gradient: LinearGradient(colors: [
    //         //         const Color(0xff6495ed),
    //         //         const Color(0xff1e90ff),
    //         //         const Color(0xff00bfff),
    //         //       ]),
    //         //       borderRadius: BorderRadius.circular(40),
    //         //     ),
    //         //   ),
    //         // ),
    //       ],
    //     ),
    //   ),
    // ),
    actions: <Widget>[
      Row(
        children: [
          Container(
            height: 45,
            constraints: BoxConstraints(maxWidth: 170),
            child: Form(
              key: formKey,
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                ],
                maxLines: 2,
                // validator: (val) {
                //   return val.isEmpty || val.length > 12
                //       ? 'Please provide a valid Username'
                //       : null;
                // },
                controller: userPostComment,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 28, left: 10),
                  border: OutlineInputBorder(
                    //borderSide: BorderSide(color: Colors.red,),
                    ///borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: 'Room id',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(width: 55,),
          TextButton(
              child: Text('Apply'),
              onPressed: () {
                Navigator.of(context).pop();
               // sendMessageCameraAndGallery(_imageFile, context);
                FocusScope.of(context).unfocus();
              }
          ),
        ],
      ),
    ],
  );
}