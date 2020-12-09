import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_using_bloc/model/news.dart';

abstract class NewsRepository {
  Future<List<Article>> getAllNews();
}

class NewsServices implements NewsRepository {
  @override
  Future<List<Article>> getAllNews() async {
    //  List<Article> articleList = [];

    String url =
        "http://newsapi.org/v2/everything?q=bitcoin&from=2020-11-09&sortBy=publishedAt&apiKey=df74fc47f0dd401bb5e56c34893a7795";

    return getData(url);
/*    Response response = await http.get(
        "http://newsapi.org/v2/everything?q=bitcoin&from=2020-11-09&sortBy=publishedAt&apiKey=df74fc47f0dd401bb5e56c34893a7795");
    //decode the response into a json object
    var jsonData = jsonDecode(response.body);

    //check if the status of the response is OK
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((item) {
//check if the imageUrl and description are not null
        if (item["urlToImage"] != null && item["description"] != null) {
          //create an object of type NewsArticles
          Article article = Article.fromJson(item);
          print(article.toJson());
          */ /*  Article newsArticleModel = new Article(
              author: item["author"],
              title: item["title"],
              description: item["description"],
              url: item["url"],
              urlToImage: item["urlToImage"],
              content: item["content"]);
*/ /*
          //add data to news list
          articleList.add(article);
        }
      });
    }

    return articleList;*/
  }
}

abstract class CategoryRepository {
  Future<List<Article>> getCategory(String category);
}

class CategoryServices implements CategoryRepository {
  @override
  Future<List<Article>> getCategory(String category) async {
    //  List<Article> categoryNewsList = [];

    String url =
        "http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=df74fc47f0dd401bb5e56c34893a7795";
    return getData(url);

    /*var response = await http.get(url);

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

    return categoryNewsList;*/
  }
}

Future<List<Article>> getData(String url) async {
  List<Article> items = [];

  var response = await http.get(url);

  //decode the response into a json object
  var jsonData = jsonDecode(response.body);

  //check if the status of the response is OK
  if (jsonData["status"] == "ok") {
    jsonData["articles"].forEach((item) {
//check if the imageUrl and description are not null
      if (item["urlToImage"] != null && item["description"] != null) {
        //create an object of type NewsArticles
        Article article = new Article(
            author: item["author"],
            title: item["title"],
            description: item["description"],
            url: item["url"],
            urlToImage: item["urlToImage"],
            content: item["content"]);

        //add data to news list
        items.add(article);
      }
    });
  }

  return items;
}
