import 'package:flutter/material.dart';
import 'package:news_app_using_bloc/constants/Constants.dart';

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
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
            Divider(),
          ],
        ),
      ),
    );
  }
}
