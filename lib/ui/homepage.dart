import 'package:flutter/material.dart';
import 'package:news_app_using_bloc/bloc/bloc.dart';
import 'package:news_app_using_bloc/bloc/events.dart';
import 'package:news_app_using_bloc/bloc/states.dart';
import 'package:news_app_using_bloc/constants/Constants.dart';
import 'package:news_app_using_bloc/model/news.dart';
import 'package:news_app_using_bloc/widgets/error_message.dart';
import 'package:news_app_using_bloc/widgets/header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_using_bloc/widgets/loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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
            return Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
            );
          }

          return Loading();
        }),
      ],
    );
  }

}

class NewsBlogTile extends StatelessWidget {
  final urlToImage, title, description, url;

  NewsBlogTile(
      {@required this.urlToImage,
      @required this.title,
      @required this.description,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Expanded(
        child: Container(
          margin: EdgeInsets.all(NewsAppConstants().margin8),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius:
                      BorderRadius.circular(NewsAppConstants().margin8),
                  child: Image.network(urlToImage)),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: NewsAppConstants().margin16),
              ),
              SizedBox(
                height: NewsAppConstants().margin8,
              ),
              Text(
                description,
                style: TextStyle(color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}
