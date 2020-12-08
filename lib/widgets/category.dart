import 'package:flutter/material.dart';
import 'package:news_app_using_bloc/constants/Constants.dart';

//news title category
class TitleCategory extends StatelessWidget {
  final title;

  TitleCategory({this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*   String titleToLowerCase = title.toString().toLowerCase();
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Categories(categoryTitle: titleToLowerCase,)));*/
      },
      child: Container(
        margin: EdgeInsets.all(NewsAppConstants().margin8),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(NewsAppConstants().margin8),
              child: Container(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: NewsAppConstants().font16,
                      fontWeight: FontWeight.w500),
                ),
                alignment: Alignment.center,
                width: NewsAppConstants().imageWidth120,
                height: NewsAppConstants().imageHeight60,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(NewsAppConstants().margin8),
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
