import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_using_bloc/api/services/repository.dart';
import 'package:news_app_using_bloc/bloc/bloc.dart';
import 'package:news_app_using_bloc/ui/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        child: HomePage(),
        create: (context) => NewsBloc(newsRepository: NewsServices()),
      ),
    );
  }
}
