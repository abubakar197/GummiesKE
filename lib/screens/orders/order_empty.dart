import 'package:flutter/material.dart';
import 'package:gummieske/consts/colors.dart';
import 'package:gummieske/provider/dark_theme_provider.dart';
import 'package:gummieske/screens/wishlist/feeds.dart';
import 'package:provider/provider.dart';

class OrderEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 90),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://cdn3.iconfinder.com/data/icons/online-shopping-flat-flash-deals/512/Out_of_stock-512.png')),
          ),
        ),
        Text(
          'Your order is Empty',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Looks like you didn\'t \n  order anything  yet',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: themeChange.darkTheme
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
              fontSize: 26,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
          child: RaisedButton(
            onPressed: () => {Navigator.of(context).pushNamed(Feeds.routeName)},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.yellow),
            ),
            color: Colors.yellowAccent,
            child: Text(
              'shop now'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w800),
            ),
          ),
        )
      ],
    );
  }
}
