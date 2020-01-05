
import 'dart:math';
import 'package:cshannon/screens/gui2/dragbox.dart';
import 'package:cshannon/screens/gui2/guiboxes.dart';
import 'package:cshannon/screens/gui2/lrtb.dart';
import 'package:cshannon/utils/utils.dart';
import 'package:flutter/material.dart';


class GuiBox{
  LRTB loc;
  LRTB bounds=LRTB(0.0, 1.0, 0.0, 1.0);
  List<GuiBox> childrenBoxes=[];
  int currentIndex;
  DragBox currentDragBox;
  int tapCount=0;
  int myTapCount=0;
  Color color;


 // Point activeClickLocation;
  bool dismissMe=false;
  bool isDragging=false;
  bool childDragging=false;
  bool passedInChild=false;
  bool guiActive=true;
  bool isRoot=false;
  String type="";
  dynamic childCall;
  

  Widget child;
  GuiBox(this.loc, {this.color});
  bool isFocused()=>(myTapCount>0 && currentIndex==null);

  bool handleClick(Point clickLocation, ){
    print("MY LOCATION");
    loc.prnt();
  print(clickLocation);
    if(loc.isWithin(clickLocation)){
      myTapCount+=1;
      Point rs = loc.rescale(clickLocation);
      print("HANDLE CLICK");
      print(rs);
      print(clickLocation);
      print(myTapCount);
     
        if(childrenBoxes.isNotEmpty && myTapCount>1 ){//&& !passedInChild
          print("CHILD NOT EMPTY");
          int i =0;
          while(childrenBoxes.length>i && !childrenBoxes[i].handleClick(rs))i++;
          if(i==childrenBoxes.length){
            print("SELF CLICKED");
            if(currentIndex!=null){currentIndex=null;tapCount=0;}else{ tapCount+=1;}
           // if(!guiActive)return true;
            if(myTapCount>1){// && !passedInChild
                  GuiBox b= GuiBox(LRTB(rs.x, rs.x, rs.y, rs.y),color: RandomColor.next());
                  childrenBoxes.add(b); 
                  currentIndex=childrenBoxes.length-1;
                  setBounds();
                  childrenBoxes.last.fitSpace(shrink:0.75);
              }
            }

          else{
              print("CHILD $i CLICKED");
              if(currentIndex!=i){currentIndex = i;tapCount=0;}
              else tapCount+=1;
              if(tapCount>2){
              print("CHILD MULTITAP");
                
              } 
              }
        }


        else if(myTapCount>2 ){ //&& !passedInChild && guiActive&& !passedInChild
            print("SELF MULTITAP");
           
            GuiBox b= GuiBox(LRTB(rs.x, rs.x, rs.y, rs.y), color: RandomColor.next());
            childrenBoxes.add(b);
            currentIndex=childrenBoxes.length-1;
            setBounds();
              childrenBoxes.last.fitSpace(shrink:0.75);
               print("CHILD LOCATION");
               childrenBoxes.last.loc.prnt();
        }
      else{
           if(currentIndex!=null){currentIndex=null;tapCount=0;}else{ tapCount+=1;}
        }
    
      return true;
    }
    else {
      myTapCount=0;
      currentIndex=null;tapCount=0;
      return false;
    }
  }

  bool handleDrag(Point clickLocation){
   // print("HDRAG");
    print(clickLocation);
    loc.prnt();
    if(loc.isWithin(clickLocation)){
      //print("TRE");
      Point rs = loc.rescale(clickLocation);
      print(rs);
      setBounds();
      if(currentIndex!=null &&
       // tapCount>1 &&
      //!passedInChild &&
         childrenBoxes[currentIndex].handleDrag(rs)){
          print("DRAGGING child $currentIndex");
          
          childDragging=true;
          isDragging=false;
        }
        else if(!isRoot){ // && guiActive
          print("DRAGGING self");
          loc.prnt();
      currentDragBox=DragBox(loc,bounds );
      currentDragBox.isOnBox(clickLocation);
      isDragging=true;
        }
      return true;
    }
    else return false;

  }
  updateDrag(Point point) {
    if(isDragging && !isRoot) currentDragBox.updateDrag(point);
//&& !passedInChild
    else if(childDragging)childrenBoxes[currentIndex].updateDrag(loc.rescale(point));
  }
  endDrag(){
    dismissMe=false;
    setBounds();
    if(isDragging && !isRoot){
      isDragging=false;
      dismissMe=currentDragBox.endDrag();// if(dismissMe)
      currentDragBox=null;
    }else if (childDragging){
      childDragging=false;
      childrenBoxes[currentIndex].endDrag(); //currentDragBox.endDrag();  //if(currentDragBox.isDismissed()){
      if(childrenBoxes[currentIndex].dismissMe){
        print("Dismiss");
        childrenBoxes.removeAt(currentIndex);
        currentIndex=null;
      }
    }
  }

  updateBounds(LRTB neighborBox)=>
    bounds = loc.updateBounds(neighborBox, bounds);
  
  resetBounds()=>bounds=LRTB(0, 1.0, 0, 1.0);
  
  void fitSpace({double shrink}){
    loc=bounds;
    if(shrink!=null)loc.shrink(shrink);
  }
  setBounds({boxIndex}){
    if(boxIndex==null && currentIndex!=null)boxIndex=currentIndex;//if(currentBox==null)return;
    if(boxIndex==null)return;
    childrenBoxes[boxIndex].resetBounds();
    for (int boxNum=0; boxNum<childrenBoxes.length;boxNum++){
      print("BOX $boxNum BOUNDS");
      if(boxIndex!=boxNum)childrenBoxes[boxIndex].updateBounds(childrenBoxes[boxNum].loc);
    }
  }


  Widget al({Function() refresh}){
    return Align(alignment: Alignment.topRight,child: IconButton(icon: Icon(Icons.blur_circular,color: guiActive?Colors.green:Colors.grey,),
    onPressed: (){
      guiActive=!guiActive;
      if(refresh!=null)refresh();
      },
    ),
    );
  }
  Widget toWidget(Size screenSize, { Function() refresh,@required Function({Widget child}) getBox}){//Widget newChild,
    Size s = Size((loc.right-loc.left)*screenSize.width,(loc.bottom-loc.top)*screenSize.height);

     return Positioned(
       left: loc.left*screenSize.width,
       width: s.width,
       top: loc.top*screenSize.height,
       height: s.height,
       child:Stack(
         children: <Widget>[
           SizedBox.fromSize(
          size: s,
         child: Container(
           decoration: BoxDecoration(
           color:color,
           borderRadius: BorderRadius.circular(20.0),
           border:isFocused()?Border.all(color: Colors.grey, width: 5.0):null
           ),
         child:isFocused()?getBox(child:(childrenBoxes.isNotEmpty)?toStack(s, refresh: refresh, getBox: getBox):null):
         (childrenBoxes.isNotEmpty)?toStack(s, refresh: refresh, getBox: getBox):
         Center(child: Text("Box X"))
         )),
           guiActive?SizedBox.fromSize(
          size: s,
          child:Container(
            color: Colors.grey.withOpacity(0.1),
            child:al(refresh: refresh))):al(refresh: refresh)
         ],
       ));

  }
    Widget toStack(Size screenSize, {Function() refresh, @required Function({Widget child}) getBox}){
      //print(screenSize);
      List<Widget> out=[];
      childrenBoxes.forEach((f){
        out.add(f.toWidget(screenSize, refresh: refresh,getBox: getBox ));
      });
      
     // if(currentDragBox!=null)
      if(childDragging &&
      currentIndex!=null &&
      childrenBoxes[currentIndex].currentDragBox!=null
      )// && mainBoxes[currentBox].currentDragBox!=null)
      out.add( CustomPaint(
                    painter: DragPainter(
                      dragbox: childrenBoxes[currentIndex].currentDragBox
                    ), // Box Painter
                    child: Container()),);
      
      return Stack(children: out);
    }



}





