import 'package:flutter/material.dart';
import 'package:news_app_using_bloc/constants/Constants.dart';

AppBar header(context,
    {bool isAppTitle = false, String title, bool removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Text(
      isAppTitle ? NewsAppConstants().appTitle : title,
      style: TextStyle(
          fontFamily: isAppTitle ? "Signatra" : "",
          fontSize: isAppTitle
              ? NewsAppConstants().margin32
              : NewsAppConstants().font24,
          color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
