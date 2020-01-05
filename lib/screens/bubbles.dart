
// import 'dart:math';

// import 'package:cshannon/components/circ_indent_clipper.dart';

// import 'package:cshannon/components/text_builder.dart';
import 'package:cshannon/components/circ_indent_clipper.dart';
import 'package:cshannon/components/text_builder.dart';
import 'package:cshannon/controllers/scale_controller.dart';
import 'package:cshannon/state_manager.dart';
import 'package:cshannon/utils/model_builder.dart';
import 'package:cshannon/utils/utils.dart';
import 'package:flutter/material.dart';


Map<String, Color> catColors = {
  "Neuroscience":Colors.green,
  "Networks":Colors.blue,
  "AI": Colors.red,
  "Math": Colors.amber,
  "Music":Colors.deepPurple,
  "General":Colors.deepOrange,
  "Youtube":Colors.white,
  "Computers":Colors.cyan
};
class Bubbles extends StatefulWidget {
  final StateManager stateManager;
  String items;
  

  Bubbles(this.stateManager, this.items);
  @override
  _BubblesState createState() => _BubblesState();
}

class _BubblesState extends State<Bubbles>  with TickerProviderStateMixin {
  List<CustomModel> categoryBubbles = [];
  List<CustomModel> itemNodes = [];
  AnimationController animationController;
 
  List<Widget> categoryWidgets=[];
  List<Widget> nodeWidgets=[];   
  List<Widget> activeWidgets=[];
  CurvedAnimation decelerate, fastIn, easeIn;
 CustomModel centerItem, activeItem;

 List<String> types= [ "site", "youtube"];
 var lis;
 Rect centerRect, bubbleBox;//ScaleController sc;
 Status status=Status.EMPTY;
 int catShown=8;
   @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    // widget.stateManager.addListener(()=>_refresh());
     animationController= AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
      );
    _getModels();
    _sizeWidgets();
   
   // attach( widget.stateManager.sc.cenerRect(), widget.stateManager.sc.bubbleBox());
    animationController.addStatusListener((listener){
      if(listener==AnimationStatus.completed){
        print("completed");
        onComplete();
        activeWidgets=getActiveWidgets();
        setState(() {});
      }
    });
      _setCurves();
    }

  _getModels(){
    categoryBubbles=widget.stateManager.getModels("categories");
    itemNodes=widget.stateManager.getAllModels();//widget.items
    categoryBubbles.forEach((category){
     category.vars["nodes"]=  itemNodes.where((b)=>(types.contains(b.vars["type"])&& b.vars["categories"]!=null && b.vars["categories"][0]==category.vars["name"])).toList();
    });
    categoryBubbles.sort((a,b)=>b.vars["nodes"].length.compareTo(a.vars["nodes"].length));
    catShown=categoryBubbles.length;
    while(catShown> 3 && categoryBubbles[catShown-1].vars["nodes"].length==0){
      //categoryBubbles.removeLast();
      catShown-=1;
    }
  }

  _sizeWidgets(){
    categoryWidgets=[];
    nodeWidgets=[];
    centerRect = widget.stateManager.sc.centerRect();
    bubbleBox= widget.stateManager.sc.bubbleBox();
   // Map<int, Rect> categoryLocs = widget.stateManager.sc.getCategoryLocations(categoryBubbles);
    Map<int, Rect> categoryLocs = widget.stateManager.sc.getLocations(nodesShown: catShown, layoutType: BUB.OVAL, );
    categoryLocs.forEach((k, v){
     CustomModel category = categoryBubbles[k];
      //CategoryBubble category = categoryBubbles[k];
      
      if(category.vars["size"]==2)
       category.vars["loc"]=v.inflate(50.0);
      else
       category.vars["loc"]=v;

   
      
    //categoryBubbles.forEach((category){
      int len = (category.vars["nodes"].length<12)?category.vars["nodes"].length:12;
      //category.vars["loc"] = widget.stateManager.sc.getBubbleLoc(category.centerAbout, category.diameter);
      categoryWidgets.add(toCategoryWidget(category));
      //List<Rect> nodeLocs = widget.stateManager.sc.getNodeLocations(category.bubbleLoc, len);
     // Map<int, Rect> nodeLocs = widget.stateManager.sc.getNodeLocations(category.vars["loc"], len);
           if(category.vars["size"]==2){
       Map<int, Rect> nodeLocs = widget.stateManager.sc.getLocations(area:category.vars["loc"], nodesShown:len);
      nodeLocs.forEach((index, loc){
        category.vars["nodes"][index].vars["loc"]=nodeLocs[index];
        nodeWidgets.add(toNodeWidget(category.vars["nodes"][index]));
      });
       }
      // for(int y=0;y<nodeLocs.length;y++){
      //   category.nodes[y].nodeLoc=nodeLocs[y];
      //   nodeWidgets.add(toNodeWidget(category.nodes[y]));
      // }
    });
  //  categoryBubbles.sort((a,b)=>b.vars["size"].compareTo(a.vars["size"]));
  }

  onRemove(){
     activeWidgets=getActiveWidgets();
        animationController.forward(from:0.0);
        setState(() {
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
        onDoubleTap: ()=>launch(node.vars["url"]),
        onTap: (){
          setActive(node);
          activeWidgets=getActiveWidgets();
          animationController.forward(from:0.0);
          setState(() {
          });
        },
        child: Container(
              decoration: _getDecoration(node),
              padding: EdgeInsets.all(5.0),
              child: 
              CircleAvatar(
                backgroundImage:(!node.vars["imgUrl"].contains("http"))
                ? AssetImage(node.vars["imgUrl"])
                : NetworkImage(node.vars["imgUrl"]),
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
      child: 
      GestureDetector(
        onTap: (){
          if(cb.vars["size"]==1)cb.vars["size"]=2;
          else if(cb.vars["size"]==2)cb.vars["size"]=1;
          _sizeWidgets();
          setState(() {
            
          });
        },
        child: Container(decoration: BoxDecoration(
          color: cb.vars["color"].withOpacity(0.5),
          border: Border.all(color: cb.vars["color"]),
          shape: BoxShape.circle
        ),
        child: Center(
        //  alignment: Alignment.center,
          child: cb.vars["size"]==1?Text(cb.vars["name"], style: TextStyle(color: Colors.white, fontSize: 12.0),):
          Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Container(),),
              IconButton(icon: Icon(Icons.add),color: Colors.white, onPressed: (){},),
              Text(cb.vars["name"], style: TextStyle(color: Colors.white, fontSize: 12.0),),
              IconButton(icon: Icon(Icons.minimize),color: Colors.white,onPressed: (){},),
              
              Expanded(child: Container(),),
            ],
          )),),
      )
      );
  }

  String getCurrentText(){
    String out="#bold##size25#";
    if(activeItem!=null){
      out+=activeItem.vars["name"]??"";
      out+="#/bold##size20#\n";
      out+=ifIs(activeItem.vars, "description")??"";
    }
    else if (centerItem!=null){
      out+=centerItem.vars["name"]??"";
      out+="#/bold##size20#\n";
      out+=ifIs(centerItem.vars, "description")??"";
    }
    return out;
  }
  
 


   
List<Widget> getActiveWidgets(){
  List<Widget> out=[];
 // print(status);
  switch(status){
    case Status.ENTERING:
  //  print("entering");
      out.add(toAnimatedBox(from: activeItem.vars["loc"], to: centerRect, imgUrl:activeItem.vars["imgUrl"],));
     out.add(AnimatedBuilder(
        animation: animationController,
        child:   ClipPath(
            clipper: CircleIndentClipper(),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20.0)),
            padding: EdgeInsets.only(top:bubbleBox.height*0.25, left: 5.0, right: 5.0),
            child: ListView(
              children: <Widget>[
                 Container(
                    alignment:Alignment.topCenter,
                    child: toRichText({
                      "text":getCurrentText(),
                      //defaultDescription,
                      "token":"#"
                    })
                 )
              ],
            ),
          
          ),),
        builder: (context, child) {
        return   (activeItem==null && centerItem==null)?Container():
        Positioned.fromRect(
          rect:bubbleBox,
          child:Opacity(
          opacity: (animationController.value>0.8)?(animationController.value-0.8)*5.0:0.0,
          child: child,

        ));
        }
      ));
      break;
    case Status.EXITING:
    //print("exiting");
    out.add(toAnimatedBox(from: centerRect, to: centerItem.vars["loc"], imgUrl:centerItem.vars["imgUrl"],  entering: false));
      break;
    case Status.CENTER:
    //print("center");
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
                    alignment:Alignment.topCenter,
                    child: toRichText({
                      "text":getCurrentText(),
                      //defaultDescription,
                      "token":"#"
                    })
                  ),
                ],
              ),
            ),
          
          ),),)
      );
    
      out.add(
        Positioned.fromRect(
          rect: centerRect,
          child: GestureDetector(
            onDoubleTap: (){
              if(centerItem.vars.containsKey("demoPath"))widget.stateManager.changeScreen(centerItem.vars["demoPath"]);
              else if(centerItem.vars.containsKey("url"))launch(centerItem.vars["url"]);
              else if(centerItem.vars.containsKey("githubUrl"))launch(centerItem.vars["githubUrl"]);
            },
            onTap: (){
              print("remove");
            status=Status.EXITING;
            onRemove();
            //  notifyListeners();
            },
            child: Container(
                decoration: BoxDecoration( shape: BoxShape.circle,),
                padding: EdgeInsets.all(5.0),
                child: 
                CircleAvatar(
                  backgroundImage:(!centerItem.vars["imgUrl"].contains("http"))
                ? AssetImage(centerItem.vars["imgUrl"])
                : NetworkImage(centerItem.vars["imgUrl"]),
                  radius: centerRect.width/2,
                ),
     ),
          ),
        )
      );
 
      break;
    case Status.INOUT:
   // print("inout");
      out.add(toAnimatedBox(from: activeItem.vars["loc"], to: centerRect, imgUrl:activeItem.vars["imgUrl"], ));
      out.add(toAnimatedBox(from: centerRect, to: centerItem.vars["loc"], imgUrl:centerItem.vars["imgUrl"], entering: false));
      out.add(AnimatedBuilder(
        animation: animationController,
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
                     alignment:Alignment.topCenter,
                    child: toRichText({
                      "text":getCurrentText(),//defaultDescription,
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
          opacity: (animationController.value>0.8)?(animationController.value-0.8)*5.0:0.0,
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



Widget toAnimatedBox({Rect from, Rect to, String imgUrl, bool entering=true}){
    final Offset offsetToMove= to.center-from.center;

    final double max= (from.width>to.width)?from.width/2:to.width/2;
    final double min= (from.width<to.width)?from.width/2:to.width/2;
    final ImageProvider _i=(imgUrl.contains("http"))
    ? NetworkImage(imgUrl)
                : AssetImage(imgUrl)
                ;
    final double growth= (to.width-from.width)/2;
   
    return  AnimatedBuilder(
        animation: animationController,
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
   
  @override
  Widget build(BuildContext context) {
  
    return Stack(
      children: [
        Align(alignment: Alignment.topLeft,child: Row(
          children: <Widget>[
            FlatButton(
               color: types.contains("project")?Colors.blue:null,
              onPressed: (){
               if( types.contains("project"))types.remove("project");
               else types.add("project");
                _getModels();
                _sizeWidgets();
                setState(() {
                  
                });
              }, child: Text("Projects"),

            ),
            FlatButton(
               color: types.contains("site")?Colors.blue:null,
               onPressed: (){
                  if( types.contains("site"))types.remove("site");
               else types.add("site");
                _getModels();
                _sizeWidgets();
                setState(() {
                  
                });
               },
              child: Text("Sites"),

            ),
            FlatButton(
               color: types.contains("book")?Colors.blue:null,
               onPressed: (){
                  if( types.contains("book"))types.remove("book");
               else types.add("book");
                _getModels();
                _sizeWidgets();
                setState(() {
                  
                });
               },
 child: Text("Books"),
            ),
            FlatButton(
               color: types.contains("youtube")?Colors.blue:null,
               onPressed: (){
                  if( types.contains("youtube"))types.remove("youtube");
               else types.add("youtube");
                _getModels();
                _sizeWidgets();
                setState(() {
                  
                });
               },
 child: Text("Youtube"),
            ),
          ],
          ),)

      ]..addAll(categoryWidgets)..addAll(nodeWidgets)..addAll(activeWidgets)
        //getActiveWidgets(animationController)),//, 100.0, 300.0
    );
  }
}




enum Status{
  ENTERING,
  EXITING,
  CENTER,
  INOUT,
  EMPTY
}




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