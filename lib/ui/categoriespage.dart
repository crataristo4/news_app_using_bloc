import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_using_bloc/model/news.dart';
import 'package:news_app_using_bloc/widgets/header.dart';
import 'package:news_app_using_bloc/widgets/newsblog.dart';

class Categories extends StatefulWidget {
  final categoryTitle;

  Categories({this.categoryTitle});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isLoading = true;
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();

    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews categoryNews = new CategoryNews();
    await categoryNews.getCategoryNews(widget.categoryTitle);
    articles = categoryNews.categoryNewsList;
    setState(() {
      isLoading = false;
    });
  }

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
            : updateUI(articles));
  }

  Widget updateUI(List<Article> newsList) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
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
        Divider(),
      ],
    ));
  }
}

class CategoryNews {
  List<Article> categoryNewsList = [];

  //method to fetch news
  Future<void> getCategoryNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=df74fc47f0dd401bb5e56c34893a7795";

    var response = await http.get(url);

    //decode the response into a json object
    var jsonData = jsonDecode(response.body);

    //check if the status of the response is OK
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((item) {
//check if the imageUrl and description are not null
        if (item["urlToImage"] != null && item["description"] != null) {
          //create an object of type NewsArticles
          Article newsArticleModel = new Article(
              author: item["author"],
              title: item["title"],
              description: item["description"],
              url: item["url"],
              urlToImage: item["urlToImage"],
              content: item["content"]);

          //add data to news list
          categoryNewsList.add(newsArticleModel);
        }
      });
    }
  }
}
