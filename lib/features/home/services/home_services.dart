// ignore_for_file: use_build_context_synchronously,, non_constant_identifier_names
import 'dart:convert';

import 'package:mytoys/constants/error_handling.dart';
import 'package:mytoys/constants/global_variables.dart';
import 'package:mytoys/constants/utils.dart';
import 'package:mytoys/models/product.dart';
import 'package:mytoys/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }

  Future<List<Product>> fetchSeeAllProducts({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> Allproduct = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/products/seeall'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            Allproduct.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return Allproduct;
  }
}

// Future<List<Product>> fetchSeeAllProducts({
//   required BuildContext context,
// }) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//   List<Product> Allproduct = [];
//   try {
//     http.Response res =
//         await http.get(Uri.parse('$uri/api/products/seeAll'), headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'x-auth-token': userProvider.user.token,
//     });

//     httpErrorHandle(
//       response: res,
//       context: context,
//       onSuccess: () {
//         for (int i = 0; i < jsonDecode(res.body).length; i++) {
//           Allproduct.add(
//             Product.fromJson(
//               jsonEncode(
//                 jsonDecode(res.body)[i],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }
//   return Allproduct;
// }
