import 'package:flutter/material.dart';

class ShowErrorMessage extends StatelessWidget {
  final errorMessage;
  final Function onTap;

  ShowErrorMessage({this.errorMessage,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: Center(
        child: Text(
          errorMessage,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      )),
    );
  }
}
