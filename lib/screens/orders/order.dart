import 'package:flutter/material.dart';
import 'package:gummieske/consts/my_icons.dart';
import 'package:gummieske/provider/orders_provider.dart';
import 'package:gummieske/screens/orders/order_empty.dart';
import 'package:gummieske/screens/orders/order_full.dart';
import 'package:gummieske/services/global_method.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  static String routeName = '/Order';

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final orderProvider = Provider.of<OrdersProvider>(context);
    // final cartProvider = Provider.of<CartProvider>(context);
    print('orderProvider.getOrders.length ${orderProvider.getOrders.length}');

    return FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
          return orderProvider.getOrders.isEmpty
              ? Scaffold(body: OrderEmpty())
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.yellow,
                    title: Text('Orders (${orderProvider.getOrders.length})',
                        style: TextStyle(color: Colors.black)),
                    actions: [
                      IconButton(
                        onPressed: () {
                          // globalMethods.showDialogg(
                          //   'Clear cart!',
                          //   'Your cart will be cleared!',
                          //   () => cartProvider.clearCart(),
                          //   context,
                          // );
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
                      itemCount: orderProvider.getOrders.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return ChangeNotifierProvider.value(
                          value: orderProvider.getOrders[index],
                          child: OrderFull(),
                        );
                      },
                    ),
                  ));
        });
  }
}
