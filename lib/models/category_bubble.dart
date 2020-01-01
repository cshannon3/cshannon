
import 'dart:math';

import 'package:cshannon/controllers/scale_controller.dart';
import 'package:cshannon/models/item_node.dart';
import 'package:flutter/material.dart';

class CategoryBubble{
  final String name;
  final int id;
  Color color;
  Rect bubbleLoc;
  List<ItemNode> nodes;
  
  Point centerAbout;
  double diameter;
  CategoryBubble({this.name, this.id, this.centerAbout, this.diameter, this.color});
}

  // init(ScaleController sc, List<ItemNode> childrenNodes){
  //   //nodes = bubs.where((b)=>(b.categories!=null && b.categories[0]==name)).toList();
  //   nodes=childrenNodes;
  //   int len = nodes.length;
  //   if(len>8)len=8;
  //   bubbleLoc = sc.getBubbleLoc(centerAbout, diameter);
  //   List<Rect> nodeLocs = sc.getNodeLocations(bubbleLoc, len);
  //   for(int y=0;y<nodeLocs.length;y++){
  //     nodes[y].nodeLoc=nodeLocs[y];
  //   }
  // }

 



//  Widget toWidget(){
//     return Positioned.fromRect(
//       rect: bubbleLoc,
//       child: Container(decoration: BoxDecoration(
//         color: color.withOpacity(0.5),
//         border: Border.all(color: color),
//         shape: BoxShape.circle
//       ),
//       child: Align(
//         alignment: Alignment.center,
//         child: Padding(
//           padding: const EdgeInsets.only(top:20.0),
//           child: Text(name, style: TextStyle(color: Colors.white, fontSize: 12.0),),// TODO fonsize of label
//         )),)
//       );
//   }

//   List<Widget> toWidgets({AnimationController anim, Function(ItemNode) onTap}){
//     List<Widget> out=[];
//     nodes.forEach((b){
//       if(b.nodeLoc!=null)out.add(b.toWidget(()=>onTap(b)));//s, 
//     });
//     return out;
//   }