// import 'package:mytoys/constants/global_variables.dart';
// import 'package:mytoys/features/home/screens/category_deals_screen.dart';
// import 'package:flutter/material.dart';

// class TopCategories extends StatelessWidget {
//   const TopCategories({Key? key}) : super(key: key);

//   // void navigateToCategoryPage(BuildContext context, String category) {
//   //   Navigator.pushNamed(context, CategoryDealsScreen.routeName,
//   //       arguments: category);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 80,
//       child: ListView.builder(
//         itemCount: GlobalVariables.categoryImages.length,
//         scrollDirection: Axis.horizontal,
//         itemExtent: 82,
//         itemBuilder: (context, index) {
//           return GestureDetector(
            
//               GlobalVariables.categoryImages[index]['title']!,
            
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(50),
//                     child: Image.asset(
//                       GlobalVariables.categoryImages[index]['image']!,
//                       fit: BoxFit.cover,
//                       height: 50,
//                       width: 50,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   GlobalVariables.categoryImages[index]['title']!,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
