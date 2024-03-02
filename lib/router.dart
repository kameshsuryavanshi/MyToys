// ignore_for_file: prefer_const_constructors

import 'package:mytoys/common/widgets/bottom_bar.dart';
import 'package:mytoys/features/address/screens/address_screen.dart';
import 'package:mytoys/features/admin/screens/add_product_screen.dart';
import 'package:mytoys/features/auth/screens/auth_screen.dart';
import 'package:mytoys/features/home/screens/category_deals_screen.dart';
import 'package:mytoys/features/home/screens/home_screen.dart';
import 'package:mytoys/features/home/widgets/see_all.dart';
import 'package:mytoys/features/order_details/screens/order_details.dart';
import 'package:mytoys/features/product_details/screens/product_details_screen.dart';
import 'package:mytoys/features/search/screens/search_screen.dart';
import 'package:mytoys/models/order.dart';
import 'package:mytoys/models/product.dart';
import 'package:flutter/material.dart';
import 'package:mytoys/features/address/screens/upi.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SeeAllScreen.routeName:
      // var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SeeAllScreen(),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case payment.routeName:
      // var address = routeSettings.arguments as String;
      var address = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => payment(
          address: address,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
