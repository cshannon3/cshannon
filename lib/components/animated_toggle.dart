
import 'package:flutter/material.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> toggleOptions;
  final Rect location;
  final int initialIndex;
  Color backgroundColor;
  Color primaryColor;
  final Function(int) onToggle;
  Color fontColor;

  

  AnimatedToggle({Key key, this.toggleOptions, this.location, this.onToggle, this.initialIndex=0, this.backgroundColor=Colors.grey, this.primaryColor=Colors.pink,this.fontColor=Colors.white}) : super(key: key);
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle>
    with TickerProviderStateMixin {
    
  AnimationController animationController;
  int currentIndex;
  //Color primaryColor, backgroundColor;
  
  
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    
  }

  @override
  Widget build(BuildContext context) {
 
   return Positioned.fromRect(
     rect: widget.location,
      child: GestureDetector(
                onPanStart: onPanStart,
                onPanUpdate: onPanUpdate,
                onPanEnd: 
                    onPanEnd, // onDoubleTap: d.onDoubleTap, //   onLongPress: d.onLongPress,
                onTapUp: onTapUp,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: widget.backgroundColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20.0)
           ),
           child: Stack(children: <Widget>[

             Center(
               child: SizedBox.fromSize(
                 size:widget.location.size,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: List.generate(widget.toggleOptions.length, (i){
                     return Text(widget.toggleOptions[i], style: TextStyle(color: widget.fontColor),);
                   }),
                 ),
               ),
             )
           ],),
        ),
      )
      );
    
  }



  onTapUp(TapUpDetails details) {
    print("TAP UP");
  
  }

  onPanStart(DragStartDetails details) {
    print("PAN START");

  }

  onPanUpdate(DragUpdateDetails details) {

  }

  onPanEnd(DragEndDetails details) {

  }
}


  

