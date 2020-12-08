import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_using_bloc/bloc/bloc.dart';
import 'package:news_app_using_bloc/bloc/events.dart';
import 'package:news_app_using_bloc/bloc/states.dart';
import 'package:news_app_using_bloc/constants/Constants.dart';
import 'package:news_app_using_bloc/model/news.dart';
import 'package:news_app_using_bloc/widgets/categoryitems.dart';
import 'package:news_app_using_bloc/widgets/error_message.dart';
import 'package:news_app_using_bloc/widgets/header.dart';
import 'package:news_app_using_bloc/widgets/loading.dart';
import 'package:news_app_using_bloc/widgets/newsblog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categoryItems;

  @override
  void initState() {
    super.initState();
    categoryItems = getAllCategories();
    _loading();
  }

  _loading() async {
    context.bloc<NewsBloc>().add(NewsEvents.fetchNews);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: _newsBody(),
    );
  }

  _newsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        //category list
        Container(
          padding:
          EdgeInsets.symmetric(horizontal: NewsAppConstants().margin16),
          height: NewsAppConstants().columnHeight70,
          child: ListView.builder(
            itemCount: categoryItems.length,
            itemBuilder: (context, index) {
              return TitleCategory(
                title: categoryItems[index],
              );
            },
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          ),
        ),

        Divider(),

        BlocBuilder<NewsBloc, NewsState>(builder: (_, NewsState newsState) {
          //check states and update UI
          if (newsState is NewsErrorState) {
            // shows an error widget when something goes wrong
            final error = newsState.error;
            final errorMsg = "${error.message}\nTap to retry";
            ShowErrorMessage(
              errorMessage: errorMsg,
              onTap: _loading,
            );
          }
          if (newsState is NewsLoadedState) {
            List<Article> newsList = newsState.newsList;
            return updateUI(newsList);
          }

          return Loading();
        }),
      ],
    );
  }

  Widget updateUI(List<Article> newsList) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return NewsBlogTile(
                    urlToImage: newsList[index].urlToImage,
                    title: newsList[index].title,
                    description: newsList[index].description,
                    url: newsList[index].url,
                  );
                }),
          ),
        ],
      ),
    );
  }

  //list of items to display as news category
  getAllCategories() {
    List<String> categoryList = [
      "Business",
      "Entertainment",
      "General",
      "Sports",
      "Technology",
      "Health",
      "Science"
    ];
    return categoryList;
  }
}

