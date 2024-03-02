// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:mytoys/common/widgets/loader.dart';
import 'package:mytoys/constants/global_variables.dart';
import 'package:mytoys/features/home/services/home_services.dart';
import 'package:mytoys/features/product_details/screens/product_details_screen.dart';
import 'package:mytoys/models/product.dart';
import 'package:flutter/material.dart';

class SeeAllScreen extends StatefulWidget {
  static const String routeName = '/SeeAll-deals';
  const SeeAllScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  List<Product>? Allproduct;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchSeeAllProducts();
  }

  fetchSeeAllProducts() async {
    Allproduct = await homeServices.fetchSeeAllProducts(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            "See all ...",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Allproduct == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping on MyToys...',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 680,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 10),
                    itemCount: Allproduct!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 1.4,
                      // mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final product = Allproduct![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailScreen.routeName,
                            arguments: product,
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    product.images[0],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 5,
                                right: 15,
                              ),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
