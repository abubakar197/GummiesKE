import 'package:flutter/material.dart';
import 'package:gummieske/consts/inner_screens/categories_feeds.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Extracts',
      'categoryImagePath': 'assets/images/extracts_I.jpeg',
    },
    {
      'categoryName': 'Tinctures',
      'categoryImagePath': 'assets/images/tinctures.png',
    },
    {
      'categoryName': 'Essential Oils',
      'categoryImagePath': 'assets/images/Essential Oils.jpeg',
    },
    {
      'categoryName': 'Edibles',
      'categoryImagePath': 'assets/images/edibles.jpeg',
    },
    {
      'categoryName': 'Topicals',
      'categoryImagePath': 'assets/images/topical.jpeg',
    },
    {
      'categoryName': 'Accessories',
      'categoryImagePath': 'assets/images/accessories.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CategoriesFeedsScreen.routeName,
                arguments: '${categories[widget.index]['categoryName']}');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              image: DecorationImage(
                  image:
                      AssetImage(categories[widget.index]['categoryImagePath']),
                  fit: BoxFit.cover),
            ),
            margin: EdgeInsets.symmetric(horizontal: 9),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 9),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[widget.index]['categoryName'],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19,
                color: Theme.of(context).textSelectionColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
