import 'package:flutter/material.dart';
import 'package:fl_ecommerce/modules/screens/welcome/walkthrough_page.dart';
import 'package:fl_ecommerce/modules/screens/welcome/login_page.dart';
import 'package:fl_ecommerce/modules/screens/welcome/landing_page.dart';
import 'package:fl_ecommerce/modules/screens/products/products_page.dart';
import 'package:fl_ecommerce/modules/screens/cart/cart_page.dart';
import 'package:fl_ecommerce/modules/screens/transactions/transactions_page.dart';
import 'package:fl_ecommerce/modules/screens/account/account_page.dart';

// import 'package:fl_ecommerce/second_page.dart';

class AppRoutes {
  static const String initial = '/';

  static const String login = '/login';
  static const String landing = '/landing';
  static const String products = '/products';
  static const String cart = '/cart';
  static const String transactions = '/transactions';
  static const String account = '/account';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => WalkthroughPage(),
    login: (context) => LoginPage(),
    landing: (context) => LandingPage(),
    products: (context) => ProductsPage(),
    cart: (context) => CartPage(),
    transactions: (context) => TransactionsPage(),
    account: (context) => AccountPage(),
    
  };
}