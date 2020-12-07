import 'package:flutter_bloc/flutter_bloc.dart';
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
        newsList = (await newsRepository.getAllNews());
        yield NewsLoadedState(newsList: newsList);
    }
  }
}
