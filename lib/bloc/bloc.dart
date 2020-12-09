import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_using_bloc/api/exceptions/new_exceptions.dart';
import 'package:news_app_using_bloc/api/services/repository.dart';
import 'package:news_app_using_bloc/bloc/events.dart';
import 'package:news_app_using_bloc/bloc/states.dart';
import 'package:news_app_using_bloc/model/news.dart';

class NewsBloc extends Bloc<NewsEvents, NewsState> {
  //List<News> newsList;
  List<Article> newsList;

  // final NewsRepo newsRepository;
  final NewsRepository newsRepository;

  NewsBloc({this.newsRepository}) : super(NewsInitialState());

  @override
  Stream<NewsState> mapEventToState(NewsEvents event) async* {
    switch (event) {
      case NewsEvents.fetchNews:
        yield NewsLoadingState();
        try {
          newsList = (await newsRepository.getAllNews());
          yield NewsLoadedState(newsList: newsList);
        } on SocketException {
          NewsErrorState(
              error: NoInternetException(errorMessage: "No Internet"));
        } on FormatException {
          NewsErrorState(
              error: InvalidFormatException(message: "Invalid response"));
        } on HttpException {
          yield NewsErrorState(
              error: NoServicesFoundException(message: "No Services found"));
        } catch (e) {
          yield NewsErrorState(
              error:
              UnknownErrorException(message: "An Unknown error occurred"));
        }
    }
  }
}

/*class ArticlesBloc extends Bloc<NewsEvents, NewsState> {
  List<Article> articlesList;
  final category;

  final ArticlesRepository articlesRepository;

  ArticlesBloc({this.articlesRepository, this.category})
      : super(NewsInitialState());

  @override
  Stream<NewsState> mapEventToState(NewsEvents event) async* {
    switch (event) {
      case NewsEvents.fetchNews:
        yield NewsLoadingState();
        try {
          articlesList = await articlesRepository.getAllArticles(category);
          yield ArticleLoadedState(newsList: articlesList , category: category);
        } on SocketException {
          NewsErrorState(
              error: NoInternetException(errorMessage: "No Internet"));
        } on FormatException {
          NewsErrorState(
              error: InvalidFormatException(message: "Invalid response"));
        } on HttpException {
          yield NewsErrorState(
              error: NoServicesFoundException(message: "No Services found"));
        } catch (e) {
          yield NewsErrorState(
              error:
                  UnknownErrorException(message: "An Unknown error occurred"));
        }
    }
  }
}*/
