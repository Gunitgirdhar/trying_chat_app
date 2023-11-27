import 'package:flutter/material.dart';

class myContainer extends StatelessWidget {
  TextEditingController mController;
  IconData mIcon;
  String data;

  myContainer({required this.mController,required this.mIcon,required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(40,0,40,0),
      child: TextFormField(
        controller: mController,
        decoration:InputDecoration(
            prefixIcon: Icon(mIcon),
            labelText: data,
            border: OutlineInputBorder()

        ) ,
      ),
    );
  }
}
