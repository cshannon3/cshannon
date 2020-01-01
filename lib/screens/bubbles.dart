
// import 'dart:math';

// import 'package:cshannon/components/circ_indent_clipper.dart';

// import 'package:cshannon/components/text_builder.dart';
import 'package:cshannon/controllers/animation_controller.dart';
import 'package:cshannon/models/category_bubble.dart';
import 'package:cshannon/models/item_node.dart';
import 'package:cshannon/state_manager.dart';
import 'package:cshannon/utils/model_builder.dart';
import 'package:cshannon/utils/utils.dart';
import 'package:flutter/material.dart';



class Bubbles extends StatefulWidget {
  final StateManager stateManager;
  

  Bubbles(this.stateManager);
  @override
  _BubblesState createState() => _BubblesState();
}

class _BubblesState extends State<Bubbles>  with TickerProviderStateMixin {
  List<CustomModel> categoryBubbles = [];
  List<CustomModel> itemNodes = [];
  AnimController anim;
  AnimationController animationController;
 
  List<Widget> categoryWidgets=[];
  List<Widget> nodeWidgets=[];   
  List<Widget> activeWidgets=[];
  CurvedAnimation decelerate, fastIn, easeIn;
   @override
  void dispose() {
    animationController.dispose();
    //anim.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
     animationController= AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
      );
    anim = widget.stateManager.animController;
    // Set up all of the formatting info for bubbles
    categoryBubbles=widget.stateManager.getModels("categories");
    //categories;
    itemNodes=widget.stateManager.getModels("nodes");
    //.items;

    categoryBubbles.forEach((category){
     category.vars["nodes"]=  itemNodes.where((b)=>(b.vars["categories"]!=null && b.vars["categories"][0]==category.vars["name"])).toList();
    });
    print(categoryBubbles.length);
    categoryBubbles.sort((a,b)=>b.vars["nodes"].length.compareTo(a.vars["nodes"].length));
    while(categoryBubbles.last.vars["nodes"].length==0){
      categoryBubbles.removeLast();
    }
    print(categoryBubbles.length);
    sizeWidgets();
   
   // anim.attach( widget.stateManager.sc.centerRect(), widget.stateManager.sc.bubbleBox());
    animationController.addStatusListener((listener){
      if(listener==AnimationStatus.completed){
        print("completed");
        anim.onComplete();
        activeWidgets=anim.getActiveWidgets(animationController);
        setState(() {});
      }
    });
      anim.addListener((){
        activeWidgets=anim.getActiveWidgets(animationController);
        animationController.forward(from:0.0);
        setState(() {
        });
      });
      _setCurves();

      widget.stateManager.addListener((){
        setState(() {
          sizeWidgets();
          activeWidgets=anim.getActiveWidgets(animationController);
        });
      });
    }

  sizeWidgets(){
    categoryWidgets=[];
    nodeWidgets=[];
    anim.attach( widget.stateManager.sc.centerRect(), widget.stateManager.sc.bubbleBox());
    Map<int, Rect> categoryLocs = widget.stateManager.sc.getCategoryLocations(categoryBubbles);
    categoryLocs.forEach((k, v){
     CustomModel category = categoryBubbles[k];
      //CategoryBubble category = categoryBubbles[k];
      category.vars["loc"]=v;
    //categoryBubbles.forEach((category){
      int len = (category.vars["nodes"].length<8)?category.vars["nodes"].length:8;
      //category.vars["loc"] = widget.stateManager.sc.getBubbleLoc(category.centerAbout, category.diameter);
      categoryWidgets.add(toCategoryWidget(category));
      //List<Rect> nodeLocs = widget.stateManager.sc.getNodeLocations(category.bubbleLoc, len);
      Map<int, Rect> nodeLocs = widget.stateManager.sc.getNodeLocations(category.vars["loc"], len);
      nodeLocs.forEach((index, loc){
        category.vars["nodes"][index].vars["loc"]=nodeLocs[index];
        nodeWidgets.add(toNodeWidget(category.vars["nodes"][index]));
      });
      // for(int y=0;y<nodeLocs.length;y++){
      //   category.nodes[y].nodeLoc=nodeLocs[y];
      //   nodeWidgets.add(toNodeWidget(category.nodes[y]));
      // }
    });
  }

_setCurves(){
  decelerate= CurvedAnimation(
       parent: animationController,
       curve: Curves.decelerate
     );
    fastIn = CurvedAnimation(
       parent: animationController,
       curve: Curves.fastLinearToSlowEaseIn
     );
      easeIn= CurvedAnimation(
       parent: animationController,
       curve: Curves.easeIn
     );
}

   Widget toNodeWidget( CustomModel node){//Size screenSize,
     return (node.vars["loc"]==null)?null:
     Positioned.fromRect(
       rect: node.vars["loc"],
      child:GestureDetector(
        onLongPress: ()=>launch(node.vars["url"]),
        onTap: (){
          anim.setActive(node);
          activeWidgets=anim.getActiveWidgets(animationController);
          animationController.forward(from:0.0);
          setState(() {
          });
        },
        child: Container(
              decoration: _getDecoration(node),
              padding: EdgeInsets.all(5.0),
              child: 
              CircleAvatar(
                backgroundImage:NetworkImage(node.vars["imgUrl"]),
                radius: node.vars["loc"].width/2??double.maxFinite,
              ),
            ),
      )
     );
  }

  BoxDecoration _getDecoration(CustomModel node){

    if(node.vars["categories"].isEmpty) return BoxDecoration( shape: BoxShape.circle,);
    List<Color> colors = [];
    node.vars["categories"].forEach((c){
      if(catColors.containsKey(c))colors.add(catColors[c]);
    });
    if(colors.isEmpty) return BoxDecoration( shape: BoxShape.circle,);
    if (colors.length==1)
       return new BoxDecoration( shape: BoxShape.circle,color: colors[0] );
    else 
      return BoxDecoration(
        shape: BoxShape.circle,
        gradient:new LinearGradient(
        colors:colors,
      ),
      );
  }


 
   Widget toCategoryWidget(CustomModel cb){
    return Positioned.fromRect(
      rect: cb.vars["loc"],
      child: Container(decoration: BoxDecoration(
        color: cb.vars["color"].withOpacity(0.5),
        border: Border.all(color: cb.vars["color"]),
        shape: BoxShape.circle
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Text(cb.vars["name"], style: TextStyle(color: Colors.white, fontSize: 12.0),),// TODO fonsize of label
        )),)
      );
  }
  
 


   

   
  @override
  Widget build(BuildContext context) {
  
    return Stack(
      children: []..addAll(categoryWidgets)..addAll(nodeWidgets)..addAll(activeWidgets)
        //anim.getActiveWidgets(animationController)),//, 100.0, 300.0
    );
  }
}


  //  Widget toNodeWidget( ItemNode node){//Size screenSize,
  //    return (node.nodeLoc==null)?null:
  //    Positioned.fromRect(
  //      rect: node.nodeLoc,
  //     child:GestureDetector(
  //       onLongPress: ()=>launch(node.url),
  //       onTap: (){
  //         anim.setActive(node);
  //         activeWidgets=anim.getActiveWidgets(animationController);
  //         animationController.forward(from:0.0);
  //         setState(() {
            
  //         });
  //       },
  //       child: Container(
  //             decoration: _getDecoration(node),
  //             padding: EdgeInsets.all(5.0),
  //             child: 
  //             CircleAvatar(
  //               backgroundImage:node.image,
  //               radius: node.nodeLoc.width/2??double.maxFinite,
  //             ),
  //           ),
  //     )
  //    );
  // }

  // BoxDecoration _getDecoration(ItemNode node){

  //   if(node.categories.isEmpty) return BoxDecoration( shape: BoxShape.circle,);
  //   List<Color> colors = [];
  //   node.categories.forEach((c){
  //     if(catColors.containsKey(c))colors.add(catColors[c]);
  //   });
  //   if(colors.isEmpty) return BoxDecoration( shape: BoxShape.circle,);
  //   if (colors.length==1)
  //      return new BoxDecoration( shape: BoxShape.circle,color: colors[0] );
  //   else 
  //     return BoxDecoration(
  //       shape: BoxShape.circle,
  //       gradient:new LinearGradient(
  //       colors:colors,
  //     ),
  //     );
  // }


 
   Widget toCategoryWidget(CategoryBubble cb){
    return Positioned.fromRect(
      rect: cb.bubbleLoc,
      child: Container(decoration: BoxDecoration(
        color: cb.color.withOpacity(0.5),
        border: Border.all(color: cb.color),
        shape: BoxShape.circle
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Text(cb.name, style: TextStyle(color: Colors.white, fontSize: 12.0),),// TODO fonsize of label
        )),)
      );
  }










// Widget toEnteringWidget( ItemNode node){//Size screenSize,
//      return (node.nodeLoc==null)?null:
//       Container(
//               decoration: _getDecoration(node),
//               padding: EdgeInsets.all(5.0),
//               child: 
//               CircleAvatar(
//                 backgroundImage:node.image,
//                 radius: node.nodeLoc.width/2??double.maxFinite,
//               ),
//      );
//   }
//   Widget toLeavingWidget( ItemNode node){//Size screenSize,
//      return (node.nodeLoc==null)?null:
//       Container(
//               decoration: _getDecoration(node),
//               padding: EdgeInsets.all(5.0),
//               child: 
//               CircleAvatar(
//                 backgroundImage:node.image,
//                 radius: node.nodeLoc.width/2??double.maxFinite,
//               ),
//      );
//   }
//   Widget toCenterWidget( ItemNode node){//Size screenSize,
//      return (node.nodeLoc==null)?null:
//       Container(
//               decoration: _getDecoration(node),
//               padding: EdgeInsets.all(5.0),
//               child: 
//               CircleAvatar(
//                 backgroundImage:node.image,
//                 radius: node.nodeLoc.width/2??double.maxFinite,
//               ),
//      );
//   }


// ItemNode centerItem;
  //ItemNode activeItem;
  //Widget centerWidget;
  //Widget newCenterWidget;
  //double centerDiameter=0.5;
  // newCenterWidget=anim.animateBox(
    //   child: 

    // );
    //   activeItem=newBubble;
//  setState(() {
  //   if(newBubble!=centerItem)activeItem=newBubble;
  //   else activeItem = null;
  //   animationCont.forward(from: 0.0);
  //   });
  


  // List<Widget> toWidgets({AnimationController anim, Function(ItemNode) onTap}){
  //   List<Widget> out=[];
  //   nodes.forEach((b){
  //     if(b.nodeLoc!=null)out.add(b.toWidget(()=>onTap(b)));//s, 
  //   });
  //   return out;
  // }

  //  List<Widget> _bubbles(){ 
  //   List<Widget> out=[];
  //   subBubs.forEach((categoryData){
  //    out.add(categoryWidget(categoryData));
  //  });
  //   subBubs.forEach((subj){
  //    out.addAll(
       
  //    );
  //  });
  //   return out;
  // }
  // Widget toCenter(){
  //   if(centerItem==null)return Container();

  //   final Rect centerRect = widget.stateManager.sc.centerRect();
  //   final Rect nodeRect = centerItem.nodeLoc;
  
  //    Widget bub =centerItem.bubble(maxR: centerRect.width/2, minR: nodeRect.width/2, onTap: ()=>startAnimation(centerItem));
     
  //    Offset pixelsToSelf= centerRect.center-nodeRect.center;
  //    double pixelsToGrow= (nodeRect.width-centerRect.width)/2;
     

  //   return  AnimatedBuilder(
  //       animation: animationCont,
  //       child: bub,
  //       builder: (context, child) {
  //       return  Positioned.fromRect(
  //         rect: Rect.fromCircle(
  //           center: centerRect.center.translate(pixelsToSelf.dx*decelerate.value, pixelsToSelf.dy*decelerate.value),
  //           //centerRect.center+pixelsToSelf*decelerate.value,
  //          radius: (centerRect.width/2)+pixelsToGrow*fastIn.value
  //         ),
  //         child:  child
  //     );
     
  //       }
  //     );
  // }

  
  
  //  Widget toAnimated(){
  //    if(activeItem==null)return Container();
  //   final Rect centerRect = widget.stateManager.sc.centerRect();
  //    final Rect nodeRect = activeItem.nodeLoc;
  
  //    Widget bub =activeItem.bubble(maxR: centerRect.width/2, minR: nodeRect.width/2, onTap: ()=>startAnimation(activeItem));
     
  //    Offset pixelsToCenter= centerRect.center-nodeRect.center;
  //    double pixelsToGrow= (centerRect.width-nodeRect.width)/2;

    
  //   return  AnimatedBuilder(
  //       animation: animationCont,
  //       child:  bub,
  //       builder: (context, child) {
  //       return Positioned.fromRect(
  //         rect: Rect.fromCircle(
  //           center: nodeRect.center.translate(pixelsToCenter.dx*decelerate.value, pixelsToCenter.dy*decelerate.value),
  //           radius: (nodeRect.width/2)+pixelsToGrow*easeIn.value,

  //         ),
  //           child:  child
  //     );
      
  //       }
  //     );
  //  }













// animationCont = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 1000),
    // )..addListener((){
    //   if(animationCont.isCompleted){
       
    //     setState(() { 
    //        centerItem=null;
    //       if(activeItem!=null)centerItem=activeItem;
    //       animationCont.reset();
    //     });
    //   }
    // });
    

 // height: 300,
          // width: 300.0,
          // left: s.width/2-150.0,
          // top: s.height/2-150,


//     Positioned(
      // left: x+pixelsToCenter.dx*decelerate.value -currentD/2,
      // width: currentD,
      // top: y+pixelsToCenter.dy*decelerate.value- currentD/2,
      // height: currentD, 
      //       child:  child
      // );
     
     //Offset((0.5-activeItem.pt.x)*screenSize.width, (0.3-activeItem.pt.y)*screenSize.height);
     //double pixelsToGrow=scaledDL-scaledDS;

  // double scaledDL=centerDiameter*(screenSize.width+screenSize.height)/2;
    // double scaledDS=activeItem.diameterS*(screenSize.width+screenSize.height)/2;
    //  double x= activeItem.pt.x*screenSize.width;
    //  double y=activeItem.pt.y*screenSize.height;
    // Widget bub =activeItem.bubble(maxR: scaledDL, minR: scaledDS, onTap: ()=>startAnimation(activeItem));
 // left: x+pixelsToSelf.dx*decelerate.value - currentD/2,
      // width: currentD,
      // top: y+pixelsToSelf.dy*decelerate.value - currentD/2,
      // height: currentD,
        
      //    Positioned(
      // left: x+pixelsToSelf.dx*decelerate.value - currentD/2,
      // width: currentD,
      // top: y+pixelsToSelf.dy*decelerate.value - currentD/2,
      // height: currentD,
      //   child:  child
      // );

    //  double x= 0.5*screenSize.width;
    //  double y=0.3*screenSize.height;
    //   double scaledDL=centerDiameter*(screenSize.width+screenSize.height)/2;
    // double scaledDS=centerItem.diameterS*(screenSize.width+screenSize.height)/2;
    // Widget bub =centerItem.bubble(maxR: scaledDL, minR: scaledDS, onTap: ()=>startAnimation(centerItem));
    //  Offset pixelsToSelf= Offset((centerItem.pt.x-0.5)*screenSize.width, (centerItem.pt.y-0.3)*screenSize.height);

    //  double pixelsToGrow=scaledDL-scaledDS;

        

//   String defaultDescription='''Web of My Life
// Early attempt to better organizing all of the wonderful resources I have found on the internet into an easy to use and share format.

// Our brains store and retrieve information in a "network-like" fashion, so why shouldn't we do the same with external resources? To test the concept, I started to make this 'web' of my favorite resources from various different subjects.
// ''';
//   Size s;

    //  CurvedAnimation c = CurvedAnimation(
    //    parent: animationCont,
    //    curve: Curves.decelerate
    //  );
    //  CurvedAnimation e = CurvedAnimation(
    //    parent: animationCont,
    //    curve: Curves.fastLinearToSlowEaseIn
    //  );

      //  CurvedAnimation c = CurvedAnimation(
  //      parent: animationCont,
  //      curve: Curves.decelerate

  //    );
  //    CurvedAnimation e = CurvedAnimation(
  //      parent: animationCont,
  //      curve: Curves.easeIn
  //    );