
// //import 'dart:math';

// import 'package:flutter/material.dart';
// // TODO better way to deal with colors

// class ItemNode{
//   final String name;
//   final String url; 
//   final String imgUrl;
//   final int id;
//   final String description;
//   Color fontColor;
//   Rect nodeLoc;

//  // Point pt;
//   NetworkImage image;
//   List<String> categories=[];

//   ItemNode({this.imgUrl, this.name, this.url, this.categories, this.fontColor=Colors.white,this.id,  this.description}){
//     image=NetworkImage(imgUrl);
//   }
//   ItemNode copy()=>ItemNode(imgUrl: imgUrl, name: name, categories: categories,fontColor: fontColor, description: description, url: url, id:id);
// }









// //  Widget toWidget( Function() onTap){//Size screenSize,
// //      return (nodeLoc==null)?null:
// //      Positioned.fromRect(
// //        rect: nodeLoc,
// //       child: bubble(radius: nodeLoc.width/2, onTap: onTap)
// //      );
// //   }

  

//    Widget bubble({double minR, double maxR, double radius, Function() onTap}){
//        return GestureDetector(
//         onLongPress: ()=>launch(url),
//         onTap:onTap,
//         child: Container(
//               decoration: _getDecoration(),
//               padding: EdgeInsets.all(5.0),
//               child: (maxR!=null && minR!=null)?
//               CircleAvatar(
//                 backgroundImage:image,
//                 maxRadius: maxR/2,
//                 minRadius: minR/2,
//               ):
//               CircleAvatar(
//                 backgroundImage:image,
//                 radius: radius??double.maxFinite,
//               )
//               ,
//             ),
//     );
//    }
//   BoxDecoration _getDecoration(){

//     if(categories.isEmpty) return BoxDecoration( shape: BoxShape.circle,);
//     List<Color> colors = [];
//     categories.forEach((c){
//       if(catColors.containsKey(c))colors.add(catColors[c]);
//     });
//     if(colors.isEmpty) return BoxDecoration( shape: BoxShape.circle,);
//     if (colors.length==1)
//        return new BoxDecoration( shape: BoxShape.circle,color: colors[0] );
//     else 
//       return BoxDecoration(
//         shape: BoxShape.circle,
//         gradient:new LinearGradient(
//         colors:colors,
//       ),
//       );
//   }