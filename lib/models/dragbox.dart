
import 'package:flutter/material.dart';
enum DRAGSIDE{
  NONE,
  CENTER,
  LEFT,
  RIGHT, 
  TOP,
  BOTTOM
}
class DragBox {
  bool isDragging = false;
  Color color = Colors.transparent;
  DRAGSIDE dragside = DRAGSIDE.NONE;
  Rect o;
  Rect b;
  double newposition;
  Offset start, activeOffset;
  //Size size;
  DragBox(Rect initPosition, Rect initBounds){
    this.o=initPosition;
    this.b =initBounds;
  }


  bool isOnBox(Offset tap) {
      print("IN BOX");
      start = tap;
      isDragging = true;
      color = Colors.grey[400].withOpacity(.3);
      return true;
  }

  void updateDrag(Offset point) {
    if (!isDragging) return;
    activeOffset = point;
    var dragVecY = activeOffset.dy - start.dy;
    var dragVecX = activeOffset.dx - start.dx;
    final normDragVecX = (dragVecX ).clamp(-1.0, 1.0);
    final normDragVecY = (dragVecY ).clamp(-1.0, 1.0);
    if (dragside == DRAGSIDE.NONE) getdragside(dragVecX, dragVecY);
    if (dragside == DRAGSIDE.CENTER) {
      start = activeOffset;
      o=Rect.fromLTRB(
        (o.left + normDragVecX).clamp(b.left, b.right),
        (o.top + normDragVecY).clamp(b.top, b.bottom), 
       (o.right + normDragVecX).clamp(b.left, b.right),// right, 
        (o.bottom + normDragVecY).clamp(b.top, b.bottom)
        );
      
    } else if (dragside == DRAGSIDE.LEFT || dragside == DRAGSIDE.RIGHT) {
      if (dragside == DRAGSIDE.LEFT)
        newposition = (o.left + normDragVecX).clamp(b.left, b.right);
      else
        newposition = (o.right + normDragVecX).clamp(b.left, b.right);
    } else {
      if (dragside == DRAGSIDE.BOTTOM)
        newposition = (o.bottom + normDragVecY).clamp(b.top, b.bottom);
      else
        newposition = (o.top + normDragVecY).clamp(b.top, b.bottom);
    }
  }

  void getdragside(double dragVecX, double dragVecY) {

    double centerX = (o.left + (o.right - o.left) / 2);
    double centerY = (o.top + (o.bottom - o.top) / 2);
    double spanX = o.right - o.left;
    double spanY = o.bottom - o.top;
    if ((start.dx - centerX).abs() < spanX * .25 &&
        (start.dy - centerY).abs() < spanY * .25) {
      print("Center");
      dragside = DRAGSIDE.CENTER;
    } else {
      if (dragVecX.abs() > dragVecY.abs()) {
        if (start.dx - o.left > o.right - start.dx) {
          print("right");
          dragside = DRAGSIDE.RIGHT;
        }
        // if(dragVecX>0)dragside=DRAGSIDE.RIGHT;
        else {
          print("left");
          dragside = DRAGSIDE.LEFT;
        }
      } else {
        if (start.dy - o.top > o.bottom - start.dy) {
          print("down");
          dragside = DRAGSIDE.BOTTOM;
        } else {
          print("up");
          dragside = DRAGSIDE.TOP;
        }
       
      }
    }
  }


  bool endDrag({bool circle=false}) {

    o=Rect.fromLTRB(
      (dragside == DRAGSIDE.LEFT)?newposition:o.left, 
      (dragside == DRAGSIDE.TOP)?newposition:o.top, 
     (dragside == DRAGSIDE.RIGHT)?newposition:o.right, 
      (dragside == DRAGSIDE.BOTTOM)?newposition:o.bottom
    );
    activeOffset = null;
    newposition = null;
    start = null;
    dragside = DRAGSIDE.NONE;
    color = Colors.transparent;
    isDragging = false;
    return ((o.right-o.left)<0.02 || (o.bottom-o.top)<0.02);

  }
  //bool isDismissed()=>((o.right-o.left)<0.03 || (o.bottom-o.top)<0.03);

  Path drawPath(Size size) {
    if (dragside == DRAGSIDE.BOTTOM) return drawBottom(size);
    if (dragside == DRAGSIDE.TOP) return drawTop(size);
    if (dragside == DRAGSIDE.LEFT) return drawLeft(size);
    if (dragside == DRAGSIDE.RIGHT) return drawRight(size);
    return drawBox(size);
    //
    //
  }

  Path drawBox(Size size) {
   // print(size);
    final path = Path();
    // Draw the curved sections with quadratic bezier to
    // Start at the Offset of the touch
    path.moveTo(size.width * o.left, size.height * o.top);
    // draw the curvedo.left side curve
    path.lineTo(size.width * o.right, size.height * o.top);
    path.lineTo(size.width * o.right, size.height * o.bottom);
    path.lineTo(size.width * o.left, size.height * o.bottom);
    path.close();

    return path;
  }

  Path drawBottom(Size size) {
    final boxValueY = size.height * newposition;
    final prevBoxValueY = (size.height * o.bottom);
    final midPointY = ((boxValueY - prevBoxValueY) * 1.2 + prevBoxValueY)
        .clamp(0.0, size.height);
    Offset mid;

    mid = Offset(size.width * (o.left + (o.right - o.left) / 2), midPointY);

    final path = Path();
    path.moveTo(mid.dx, mid.dy);
    path.moveTo(size.width *o.left, size.height *o.top);
    path.lineTo(size.width *o.left, size.height *o.bottom);
    // draw the curvedo.left side curve
    path.quadraticBezierTo(
      mid.dx - size.width* ( o.right -o.left )/2, //x1,
      mid.dy, //y1,
       mid.dx, mid.dy
    
    );
   
    path.quadraticBezierTo(
      mid.dx + size.width* ( o.right -o.left )/2, //x1,
      mid.dy, //y1,
      size.width * o.right, //x2,
      size.height * o.bottom, //y2
    );
    path.lineTo(size.width *o.right, size.height *o.top);
    path.lineTo(size.width *o.left, size.height *o.top);
    //path.lineTo(size.width *o.left, size.height *o.bottom);
    //path.close();

    return path;
  }

  Path drawTop(Size size) {
    final boxValueY = size.height * newposition;
    final prevBoxValueY = (size.height *o.top);
    final midPointY = ((boxValueY - prevBoxValueY) * 1.2 + prevBoxValueY)
        .clamp(0.0, size.height);
    Offset mid;
  
    mid =Offset(size.width * (o.left + (o.right -o.left) / 2), midPointY);
    final path = Path();
    path.moveTo(size.width *o.left, size.height *o.bottom);
    path.lineTo(size.width *o.left, size.height *o.top);
    //path.moveTo(mid.dx, mid.dy);
      path.quadraticBezierTo(
      mid.dx-size.width* ( o.right -o.left )/2,
      mid.dy, //y1,
      mid.dx, mid.dy
      // size.width *o.left, //x2,
      // size.height *o.top, //y2
    );

  
    //path.moveTo(mid.dx, mid.dy);
    path.quadraticBezierTo(
      mid.dx + size.width* ( o.right -o.left )/2, //x1,
      mid.dy, //y1,
      size.width *o.right, //x2,
      size.height *o.top, //y2
    );
    path.lineTo(size.width *o.right, size.height *o.bottom);
    path.lineTo(size.width *o.left, size.height *o.bottom);
   // path.lineTo(size.width *o.left, size.height *o.top);
  //  path.close();

    return path;
  }

  Path drawLeft(Size size) {
    final boxValueY = size.width * newposition;
    final prevBoxValueX = (size.width *o.left);
    final midPointX = ((boxValueY - prevBoxValueX) * 1.2 + prevBoxValueX)
        .clamp(0.0, size.width);
    Offset mid;

    mid = Offset(midPointX, size.height * (o.top + (o.bottom -o.top) / 2));

    final path = Path();
    //path.moveTo(mid.dx, mid.dy);
    path.moveTo(size.width *o.right, size.height *o.top);
    path.lineTo(size.width *o.left, size.height *o.top);
    // draw the curvedo.left side curve
    path.quadraticBezierTo(
      mid.dx, //x1,
      mid.dy -size.height* ( o.bottom -o.top )/2, //y1,
      mid.dx, mid.dy
      // size.width *o.left, //x2,
      // size.height *o.top, //y2
    );
    //
    // path.lineTo(size.width*right, size.height*top);
    //path.moveTo(mid.dx, mid.dy);
    path.quadraticBezierTo(
      mid.dx, //x1,
      mid.dy +size.height* ( o.bottom -o.top )/2, //y1,
      size.width *o.left, //x2,
      size.height *o.bottom, //y2
    );
    path.lineTo(size.width *o.right, size.height *o.bottom);
    path.lineTo(size.width *o.right, size.height *o.top);
   // path.lineTo(size.width *o.left, size.height *o.top);
    //path.close();

    return path;
  }

  Path drawRight(Size size) {
    final boxValueY = size.width * newposition;
    final prevBoxValueX = (size.width *o.right);
    final midPointX = ((boxValueY - prevBoxValueX) * 1.2 + prevBoxValueX)
        .clamp(0.0, size.width);
    Offset mid;

    mid = Offset(midPointX, size.height * (o.top + (o.bottom -o.top) / 2));

    final path = Path();
 //   path.moveTo(mid.dx, mid.dy);  // draw the curvedo.left side curve

    path.moveTo(size.width *o.left, size.height *o.top);
    path.lineTo(size.width *o.right, size.height *o.top);
    
    path.quadraticBezierTo(
      mid.dx, //x1,
      mid.dy - size.height* ( o.bottom -o.top )/2, //y1,
      mid.dx, 
      mid.dy
      // size.width *o.right, //x2,
      // size.height *o.top, //y2
    );
    //
    //path.moveTo(mid.dx, mid.dy);
    path.quadraticBezierTo(
      mid.dx, //x1,
      mid.dy + size.height* ( o.bottom -o.top )/2, //y1,
      size.width *o.right, //x2,
      size.height *o.bottom, //y2
    );
    path.lineTo(size.width *o.left, size.height *o.bottom);
    path.lineTo(size.width *o.left, size.height *o.top);
    //path.lineTo(size.width *o.right, size.height *o.top);
    //path.close();

    return path;
  }

}


class DragPainter extends CustomPainter {
  final DragBox dragbox;
  final Paint boxPaint1;
  //final Paint dropPaint;

  DragPainter({
    this.dragbox,
  }) : boxPaint1 = Paint()
  //dropPaint = Paint()
  {
    boxPaint1.color = this.dragbox.color;
    boxPaint1.style = PaintingStyle.fill;
    // dropPaint.color = Colors.grey;
    // dropPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    Path pathOne = dragbox.drawPath(size);
    canvas.drawPath(pathOne, boxPaint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

