import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gummieske/consts/inner_screens/brand_navigation_rail.dart';
import 'package:gummieske/consts/inner_screens/categories_feeds.dart';
import 'package:gummieske/consts/inner_screens/product_details.dart';
import 'package:gummieske/consts/theme_data.dart';
import 'package:gummieske/provider/cart_provider.dart';
import 'package:gummieske/provider/dark_theme_provider.dart';
import 'package:gummieske/provider/favs_provider.dart';
import 'package:gummieske/provider/orders_provider.dart';
import 'package:gummieske/provider/products.dart';
import 'package:gummieske/screens/auth/forget_password.dart';
import 'package:gummieske/screens/auth/login.dart';
import 'package:gummieske/screens/auth/sign_up.dart';
import 'package:gummieske/screens/bottom_bar.dart';
import 'package:gummieske/screens/cart/cart.dart';
import 'package:gummieske/screens/landing_page.dart';
import 'package:gummieske/screens/orders/order.dart';
import 'package:gummieske/screens/upload_products_form.dart';
import 'package:gummieske/screens/user_state.dart';
import 'package:gummieske/screens/wishlist.dart';
import 'package:gummieske/screens/wishlist/feeds.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(
                  create: (_) => Products(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => OrdersProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => FavsProvider(),
                ),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeChangeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Gummies',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: UserState(),
                  // initialRoute: '/',
                  routes: {
                    // '/': (ctx) => LandingPage(),
                    // '/': (ctx) => SignUpScreen(),
                    // '/': (ctx) => LoginScreen(),

                    BrandNavigationRailScreen.routeName: (ctx) =>
                        BrandNavigationRailScreen(),
                    Cart.routeName: (ctx) => Cart(),
                    Feeds.routeName: (ctx) => Feeds(),
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    CategoriesFeedsScreen.routeName: (ctx) =>
                        CategoriesFeedsScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    LandingPage.routeName: (ctx) => LandingPage(),
                    Order.routeName: (ctx) => Order(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                  },
                );
              }));
        });
  }
}
