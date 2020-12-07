import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_using_bloc/model/news.dart';

abstract class NewsRepository {
  Future<List<Article>> getAllNews();
}

class NewsServices implements NewsRepository {
  @override
  Future<List<Article>> getAllNews() async {
    List<Article> articleList = [];

    // Uri uri = Uri.https(NewsAppConstants().baseUrl, NewsAppConstants().endPoint);
    Response response = await http.get(
        "http://newsapi.org/v2/everything?q=bitcoin&from=2020-11-07&sortBy=publishedAt&apiKey=2cd403f322434636a477589c8f07c665");
    //decode the response into a json object
    var jsonData = jsonDecode(response.body);

    //check if the status of the response is OK
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((item) {
//check if the imageUrl and description are not null
        if (item["urlToImage"] != null && item["description"] != null) {
          //create an object of type NewsArticles
          Article article = Article.fromJson(item);
        //  print(article.toJson());
          /*  Article newsArticleModel = new Article(
              author: item["author"],
              title: item["title"],
              description: item["description"],
              url: item["url"],
              urlToImage: item["urlToImage"],
              content: item["content"]);
*/
          //add data to news list
          articleList.add(article);
        }
      });
    }

    return articleList;
  }
}