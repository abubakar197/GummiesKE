import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:gummieske/consts/inner_screens/product_details.dart';
import 'package:gummieske/models/product.dart';
import 'package:gummieske/widget/feeds.dialog.dart';

import 'package:provider/provider.dart';

class FeedProducts extends StatefulWidget {
  @override
  _FeedProductsState createState() => _FeedProductsState();
}

class _FeedProductsState extends State<FeedProducts> {
  @override
  Widget build(BuildContext context) {
    final productAttributes = Provider.of<Product>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productAttributes.id),
        child: Container(
          width: 250,
          height: 290,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).backgroundColor),
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Image.network(
                            productAttributes.imageUrl,
                            // fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        // bottom: 0,
                        // right: 5,
                        // top: 5,
                        child: Badge(
                          alignment: Alignment.center,
                          toAnimate: true,
                          shape: BadgeShape.square,
                          badgeColor: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8.0)),
                          badgeContent: Text('New',
                              style: TextStyle(color: Colors.yellowAccent)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          productAttributes.description,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '\$ ${productAttributes.price}',
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${productAttributes.quantity}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.deepOrangeAccent,
                                  fontWeight: FontWeight.w600),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          FeedDialog(
                                            productId: productAttributes.id,
                                          ));
                                },
                                borderRadius: BorderRadius.circular(18.0),
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.yellow,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
