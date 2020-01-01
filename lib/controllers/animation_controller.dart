

import 'package:cshannon/components/circ_indent_clipper.dart';
import 'package:cshannon/components/text_builder.dart';
import 'package:cshannon/controllers/scale_controller.dart';
import 'package:cshannon/models/item_node.dart';
import 'package:cshannon/utils/model_builder.dart';
import 'package:flutter/material.dart';

enum Status{
  ENTERING,
  EXITING,
  CENTER,
  INOUT,
  EMPTY
}
class AnimController extends ChangeNotifier {
  //AnimationController animationController;
  CurvedAnimation decelerate, fastIn, easeIn;

 AnimController();
 //ItemNode centerItem, activeItem;//Rect centerRect;
 CustomModel centerItem, activeItem;
 Rect centerRect, bubbleBox;//ScaleController sc;
 Status status=Status.EMPTY;
 List<Widget> activeWidgets=[];

 attach( Rect c, Rect b){ //AnimationController controller,
   centerRect=c; //sc.centerRect();
   bubbleBox=b;

 }


onComplete(){
    if(status==Status.ENTERING || status== Status.INOUT){
    
         centerItem=activeItem;
         activeItem=null;
         status=Status.CENTER;
       }
       else {
         centerItem=null;
         status=Status.EMPTY;
       } 
}

setActive(CustomModel newNode){//ItemNode newNode){
  
    activeItem=newNode;
    if(status== Status.EMPTY){
      status=Status.ENTERING;
     
    }
    else if(status== Status.CENTER){
      if(centerItem==newNode)status=Status.EXITING;
      else 
        status=Status.INOUT;
    }
}



List<Widget> getActiveWidgets(AnimationController c){
  List<Widget> out=[];
  print(status);
  switch(status){
    case Status.ENTERING:
    print("entering");
      out.add(toAnimatedBox(from: activeItem.vars["loc"], to: centerRect, imgUrl:activeItem.vars["imgUrl"], a:c));
     out.add(AnimatedBuilder(
        animation: c,
        child:   ClipPath(
            clipper: CircleIndentClipper(),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20.0)),
            padding: EdgeInsets.only(top:80.0, left: 5.0, right: 5.0),
            child: ListView(
              children: <Widget>[
                Container(
                  child: toRichText({
                    "text":(activeItem!=null)? activeItem.vars["description"]??"":(centerItem!=null)?centerItem.vars["description"]??"":"",//defaultDescription,
                    "token":"#"
                  })
                ),
              ],
            ),
          
          ),),
        builder: (context, child) {
        return   (activeItem==null && centerItem==null)?Container():
        Positioned.fromRect(
          rect:bubbleBox,
          child:Opacity(
          opacity: (c.value>0.8)?(c.value-0.8)*5.0:0.0,
          child: child,

        ));
        }
      ));
      break;
    case Status.EXITING:
    print("exiting");
    out.add(toAnimatedBox(from: centerRect, to: centerItem.vars["loc"], imgUrl:centerItem.vars["imgUrl"], a:c, entering: false));
      break;
    case Status.CENTER:
    print("center");
      out.add(
        Positioned.fromRect(
          rect: centerRect,
          child: GestureDetector(
            onTap: (){
              print("remove");
            status=Status.EXITING;
              notifyListeners();
            
            },
            child: Container(
                decoration: BoxDecoration( shape: BoxShape.circle,),
                padding: EdgeInsets.all(5.0),
                child: 
                CircleAvatar(
                  backgroundImage:NetworkImage(centerItem.vars["imgUrl"]),
                  radius: centerRect.width/2,
                ),
     ),
          ),
        )
      );
      out.add(
         Positioned.fromRect(
          rect:bubbleBox,
          child:
         ClipPath(
            clipper: CircleIndentClipper(),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: EdgeInsets.only(top:bubbleBox.height*0.25, left: 5.0, right: 5.0),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: toRichText({
                      "text":(activeItem!=null)? activeItem.vars["description"]??"":(centerItem!=null)?centerItem.vars["description"]??"":"",//defaultDescription,
                      "token":"#"
                    })
                  ),
                ],
              ),
            ),
          
          ),),)
      );
    
      break;
    case Status.INOUT:
    print("inout");
      out.add(toAnimatedBox(from: activeItem.vars["loc"], to: centerRect, imgUrl:activeItem.vars["imgUrl"], a:c));
      out.add(toAnimatedBox(from: centerRect, to: centerItem.vars["loc"], imgUrl:centerItem.vars["imgUrl"], a:c, entering: false));
      out.add(AnimatedBuilder(
        animation: c,
        child:   ClipPath(
            clipper: CircleIndentClipper(),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20.0)),
            
            child: Padding(
              padding:  EdgeInsets.only(top:bubbleBox.height*0.25, left: 5.0, right: 5.0),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: toRichText({
                      "text":(activeItem!=null)? activeItem.vars["description"]??"":(centerItem!=null)?centerItem.vars["description"]??"":"",//defaultDescription,
                      "token":"#"
                    })
                  ),
                ],
              ),
            ),
          
          ),),
        builder: (context, child) {
        return   (activeItem==null && centerItem==null)?Container():
        Positioned.fromRect(
          rect:bubbleBox,
          child:Opacity(
          opacity: (c.value>0.8)?(c.value-0.8)*5.0:0.0,
          child: child,

        ));
        }
      ));
      break;
    case Status.EMPTY:
      // TODO: Handle this case.
      break;
  }
  return out;
}



Widget toAnimatedBox({Rect from, Rect to, String imgUrl, AnimationController a, bool entering=true}){
    final Offset offsetToMove= to.center-from.center;
     decelerate= CurvedAnimation(
       parent: a,
       curve: Curves.decelerate
     );
    fastIn = CurvedAnimation(
       parent: a,
       curve: Curves.fastLinearToSlowEaseIn
     );
      easeIn= CurvedAnimation(
       parent: a,
       curve: Curves.easeIn
     );
    final double max= (from.width>to.width)?from.width/2:to.width/2;
    final double min= (from.width<to.width)?from.width/2:to.width/2;
    final NetworkImage _i=NetworkImage(imgUrl);
    final double growth= (to.width-from.width)/2;
   
    return  AnimatedBuilder(
        animation: a,
        child:  Container(
              decoration: BoxDecoration( shape: BoxShape.circle,),
              padding: EdgeInsets.all(5.0),
              child: 
              CircleAvatar(
                backgroundImage:_i,
                maxRadius: max,
                minRadius: min,
              ),
     ),
        builder: (context, child) {
        return Positioned.fromRect(
          rect: Rect.fromCircle(
            center: from.center+offsetToMove*decelerate.value,
           // center: from.center*(1.0-decelerate.value)+to.center*decelerate.value,
            radius:(entering)?(from.width/2)+growth*easeIn.value:(from.width/2)+growth*fastIn.value
          ),
            child:  child
      );
        }
      );
}


}

    //activeItem=newNode;
    //animationController.forward(from:0.0);
    //notifyListeners();
  //animationController.forward(from:0.0);
  //notifyListeners();
   //sc.bubbleBox();
  //  if(animationController!=null)animationController.dispose();
  //  animationController= controller;
  //  animationController.addStatusListener((listener){
  //    if(listener==AnimationStatus.completed){
  //      if(status==Status.ENTERING || status== Status.INOUT){
  //        centerItem=activeItem;
  //        status=Status.CENTER;
  //      }else {
  //        status=Status.EMPTY;
  //      }
       
  //      notifyListeners();
  //      animationController.reset();
  //    }
  // });
  // _setCurves();
// Timer timer;
 // Stopwatch stopwatch = Stopwatch();
  
 // @override
 // void dispose() {
//super.dispose();
    //timer?.cancel();
  //}