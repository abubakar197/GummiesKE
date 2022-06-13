import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gummieske/consts/colors.dart';
import 'package:gummieske/consts/my_icons.dart';
import 'package:gummieske/provider/cart_provider.dart';
import 'package:gummieske/services/global_method.dart';
import 'package:gummieske/services/payment.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'cart_empty.dart';
import 'cart_full.dart';

class Cart extends StatefulWidget {
  static String routeName = '/CartScreen';

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  var response;
  Future<void> payWithCard({int amount}) async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    response = await StripeService.payWithNewCard(
        currency: 'USD', amount: amount.toString());
    await dialog.hide();
    print('response : ${response.success}');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 300),
    ));
  }

  GlobalMethods globalMethods = GlobalMethods();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            bottomSheet: checkoutsection(context, cartProvider.totalAmount),
            appBar: AppBar(
              backgroundColor: Colors.yellow,
              title: Text('Cart (${cartProvider.getCartItems.length})',
                  style: TextStyle(color: Colors.black)),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                      'Clear cart!',
                      'Your cart will be cleared!',
                      () => cartProvider.clearCart(),
                      context,
                    );
                    // cartProvider.clearCart();
                  },
                  iconSize: 22,
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: cartProvider.getCartItems.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                    value: cartProvider.getCartItems.values.toList()[index],
                    child: CartFull(
                      productId: cartProvider.getCartItems.keys.toList()[index],
                      // id: cartProvider.getCartItems.values.toList()[index].id,
                      // productId: cartProvider.getCartItems.keys.toList()[index],
                      // price: cartProvider.getCartItems.values.toList()[index].price,
                      // title: cartProvider.getCartItems.values.toList()[index].title,
                      // imageUrl: cartProvider.getCartItems.values.toList()[index].imageUrl,
                      // quantity: cartProvider.getCartItems.values.toList()[index].quantity,
                    ),
                  );
                },
              ),
            ),
          );
  }

  Widget checkoutsection(BuildContext ctx, double subtotal) {
    final cartProvider = Provider.of<CartProvider>(context);
    var uuid = Uuid();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 0.5))),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        ColorsConsts.black,
                        ColorsConsts.yellow,
                      ], stops: [
                        0.0,
                        0.7
                      ]),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.yellow,
                      child: InkWell(
                        onTap: () async {
                          double amountInCents = subtotal * 1000;
                          int integerAmount = (amountInCents / 10).ceil();
                          await payWithCard(amount: integerAmount);
                          if (response.success == true) {
                            User user = _auth.currentUser;
                            final _uid = user.uid;
                            cartProvider.getCartItems
                                .forEach((key, orderValue) async {
                              final orderId = uuid.v4();
                              try {
                                await FirebaseFirestore.instance
                                    .collection('order')
                                    .doc(orderId)
                                    .set({
                                  'orderId': orderId,
                                  'userId': _uid,
                                  'productId': orderValue.productId,
                                  'title': orderValue.title,
                                  'price':
                                      orderValue.price * orderValue.quantity,
                                  'imageUrl': orderValue.imageUrl,
                                  'quantity': orderValue.quantity,
                                  'orderDate': Timestamp.now(),
                                });
                              } catch (err) {
                                print('error occured $err');
                              }
                            });
                          } else {
                            globalMethods.authErrorHandle(
                                'Please enter your true information', context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Checkout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 19,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Text(
              'Total ',
              style: TextStyle(
                  color: Theme.of(ctx).textSelectionColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'US ${subtotal.toStringAsFixed(3)}',
              // textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 19,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}
