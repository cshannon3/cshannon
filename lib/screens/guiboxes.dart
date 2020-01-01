

import 'dart:math';


import 'package:cshannon/components/guibox.dart';
import 'package:cshannon/controllers/scale_controller.dart';
import 'package:cshannon/state_manager.dart';
import 'package:cshannon/utils/utils.dart';
import 'package:flutter/material.dart';

class GuiScreen extends StatefulWidget {
  final StateManager stateManager;

  const GuiScreen({Key key, this.stateManager}) : super(key: key);
  @override
  _GuiScreenState createState() => _GuiScreenState();
}

class _GuiScreenState extends State<GuiScreen> {
  bool isEditing = false;
  GuiBox rootBox;
  Offset currentTapLocation;
  ScaleController sc;

  @override
  void initState() {
    super.initState();
    sc=widget.stateManager.sc;

    
    rootBox = GuiBox(sc.fromPct(0, 1.0, 0.0, 1.0));
    rootBox.isRoot = true;
    rootBox.childrenBoxes.addAll([
      GuiBox(sc.fromPct(0.03, 0.8, .05, 0.4), color: RandomColor.next()),
      GuiBox(sc.fromPct(0.03, 0.6, .4, 0.8), color: RandomColor.next()),
      GuiBox(sc.fromPct(0.7, 0.9, .5, 0.7), color: RandomColor.next()),
    ]);
  }
  @override
  void dispose() {
    super.dispose();
  }
  updateTapLocation(Offset screenpos) =>
      currentTapLocation = screenpos;//Offset(screenpos.dx / sc.mainArea()., screenpos.dy / getH());
  delegateTap(Offset screenpos) {
    currentTapLocation = screenpos;//Offset(screenpos.dx / getW(), screenpos.dy / getH());
    //currentBox = (i<mainBoxes.length)?i:null;
  }

  onTapUp(TapUpDetails details) {
    print("TAP UP");
    updateTapLocation(details.localPosition);
    rootBox.handleClick(currentTapLocation);
    
  }

  onPanStart(DragStartDetails details) {
    print("PAN START");
    updateTapLocation(details.localPosition);
    rootBox.handleDrag(currentTapLocation);
  }

  onPanUpdate(DragUpdateDetails details) {
    // updateTapLocation(details.globalPosition);
    updateTapLocation(details.localPosition);
    rootBox.updateDrag(currentTapLocation);
  
  }

  onPanEnd(DragEndDetails details) {
    rootBox.endDrag();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
      return Stack(
      children: <Widget>[
        SizedBox.fromSize(
            child: GestureDetector(
                onPanStart: onPanStart,
                onPanUpdate: onPanUpdate,
                onPanEnd: 
                    onPanEnd, // onDoubleTap: d.onDoubleTap, //   onLongPress: d.onLongPress,
                onTapUp: onTapUp, //onTap: // onTapDown: d.onTapDown,
                child: Container(
                    color: Colors.transparent,
                    child: rootBox
                        .toStack(s, refresh: () => setState(() {})))) //
            ),
        //   wm.only("optionsOpen", optionsWidget(d.size)),
      ],
    );
  }
}

