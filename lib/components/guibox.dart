

import 'package:cshannon/models/dragbox.dart';
import 'package:cshannon/utils/utils.dart';
import 'package:flutter/material.dart';

class GuiBox{
  Rect loc;
  Rect bounds=Rect.fromLTRB(0.0, 1.0, 0, 1.0);
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
  _checkChildren(Offset clickLocation){
    print("CHILD NOT EMPTY");
          int i =0;
          while(childrenBoxes.length>i && !childrenBoxes[i].handleClick(clickLocation))i++;
          if(i==childrenBoxes.length){
            print("SELF CLICKED");
            if(currentIndex!=null){currentIndex=null;tapCount=0;}else{ tapCount+=1;}
            if(myTapCount>2)_addNewBox(clickLocation);
            else{
              print("CHILD $i CLICKED");
              if(currentIndex!=i){currentIndex = i;tapCount=0;}
              else tapCount+=1;
              if(tapCount>2){
              print("CHILD MULTITAP");
              } 
            }

  }
  }
  _addNewBox(Offset clickLocation){
    print("SELF MULTITAP");
    GuiBox b= GuiBox(Rect.fromCenter(center: clickLocation, height: 0.0, width: 0.0),color: RandomColor.next());
    childrenBoxes.add(b);
    currentIndex=childrenBoxes.length-1;
    setBounds();
    childrenBoxes.last.fitSpace(shrinkBy:0.75);
  }

  _handleClick(Offset clickLocation){
  myTapCount+=1;
      print("HANDLE CLICK");
      print(clickLocation); print(myTapCount);
        if(childrenBoxes.isNotEmpty && myTapCount>1 )_checkChildren(clickLocation);
        else if(myTapCount>2 )_addNewBox(clickLocation);
        
      else{
           if(currentIndex!=null){currentIndex=null;tapCount=0;}else{ tapCount+=1;}
        }
    
      return true;
    

  }

  bool handleClick(Offset clickLocation){
    print(loc.center);print(clickLocation);
    if(loc.contains(clickLocation)){
    _handleClick(clickLocation);
    return true;
  }
    else {
      myTapCount=0;
      currentIndex=null;tapCount=0;
      return false;
    }
  }
  _handleDrag(Offset clickLocation){
    setBounds();
      if(currentIndex!=null &&
         childrenBoxes[currentIndex].handleDrag(clickLocation)){
          print("DRAGGING child $currentIndex");
          childDragging=true;
          isDragging=false;
        }
        else if(!isRoot){ // && guiActive
          print("DRAGGING self");
        //  loc.prnt();
      currentDragBox=DragBox(loc,bounds );
      currentDragBox.isOnBox(clickLocation);
      isDragging=true;
        }
  }

  bool handleDrag(Offset clickLocation){
    print(clickLocation);
    if(loc.contains(clickLocation)){
      //Offset rs = loc.rescale(clickLocation);
      _handleDrag(clickLocation);
      return true;
    }
    else return false;

  }
  updateDrag(Offset point) {
    if(isDragging && !isRoot) currentDragBox.updateDrag(point);

    else if(childDragging)childrenBoxes[currentIndex].updateDrag(point);
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

 
    
  
  resetBounds()=>bounds=loc;
  
  void fitSpace({double shrinkBy}){
    loc=bounds;
    if(shrink!=null)shrink(shrinkBy);
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
  Widget toWidget(Size screenSize, {Widget newChild, Function() refresh}){
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
         child: Container(color:color,
         child:
         (newChild!=null)?Container(color:Colors.green,child: newChild)
        // :(childCall!=null)?childCall()
         :(childrenBoxes.isNotEmpty)?toStack(s, refresh: refresh):Text("Hello")
         )),
           guiActive?SizedBox.fromSize(
          size: s,
          child:Container(
            color: Colors.grey.withOpacity(0.1),
            child:al(refresh: refresh))):al(refresh: refresh)
         ],
       ));

  }
    Widget toStack(Size screenSize, {Function() refresh}){
      List<Widget> out=[];
      childrenBoxes.forEach((f){
        out.add(f.toWidget(screenSize, refresh: refresh));
      });
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


    Offset rescale(Offset clickLocation){
      Offset p=Offset(
        (clickLocation.dx-loc.left)/(loc.right-loc.left),
        (clickLocation.dy-loc.top)/(loc.bottom-loc.top), );
        return p;
    }
    shrink(double pct){
      var w = (1-pct)*(loc.right-loc.left)/2;
      var h = (1-pct)*(loc.bottom-loc.top)/2;
      loc= Rect.fromLTRB(loc.left+w, loc.top+h,loc.right-w, loc.bottom-h);
    }
    
    updateBounds(Rect neighborBox){
      if(onEdge(neighborBox))return;
       
      double l= (neighborBox.right<loc.left && neighborBox.right>bounds.left)?neighborBox.right:bounds.left; //left, 
       double r=(neighborBox.left>loc.right && neighborBox.left<bounds.right)?neighborBox.left:bounds.right;
       double t=(neighborBox.bottom<loc.top && neighborBox.bottom >bounds.top)?neighborBox.bottom:bounds.top;
       double b= (neighborBox.top>loc.bottom && neighborBox.top<bounds.bottom)?neighborBox.top:bounds.bottom;
    
               
      bounds = Rect.fromLTRB(l, t, r, b);
    }
    bool onEdge(Rect neighborBox){
      if((neighborBox.bottom<loc.top ||neighborBox.top>loc.bottom) &&(neighborBox.left>loc.right || neighborBox.right<loc.left))return true;
      return false;
    }
    // shrink(double pct){
    //   var w = (1-pct)*(right-left)/2;
    //   var h = (1-pct)*(bottom-top)/2;
      
    //   right=right-w;
    //   left=left+w;
    //   bottom=bottom-h;
    //   top=top+h;

    // }


 }
