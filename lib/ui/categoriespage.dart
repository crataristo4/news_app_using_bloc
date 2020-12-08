import 'package:flutter/material.dart';
import 'package:news_app_using_bloc/widgets/header.dart';

class Categories extends StatefulWidget {
  final categoryTitle;

  Categories({this.categoryTitle});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getCategoryNews();
  }

  getCategoryNews() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,
          isAppTitle: false,
          title: widget.categoryTitle[0].toString().toUpperCase() +
              widget.categoryTitle.toString().substring(1)),
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(), //progress bar
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    //news tiles
                    Container(),
                  ],
                ),
              ),
            ),
    );
  }
}
