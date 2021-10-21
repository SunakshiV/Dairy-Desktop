import 'package:flutter/material.dart';
class DragGame extends StatefulWidget {
  @override
  _DragGameState createState() => new _DragGameState();
}

class _DragGameState extends State<DragGame> {
  int boxNumberIsDragged;

  @override
  void initState() {
    boxNumberIsDragged = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        constraints: BoxConstraints.expand(),
        color: Colors.grey,
        child: new Stack(
          children: <Widget>[
            buildDraggableBox(1, Colors.red, new Offset(30.0, 100.0)),
            buildDraggableBox(2, Colors.yellow, new Offset(30.0, 200.0)),
            buildDraggableBox(3, Colors.green, new Offset(30.0, 300.0)),
          ],
        ));
  }

  Widget buildDraggableBox(int boxNumber, Color color, Offset offset) {
    return new Draggable(
      maxSimultaneousDrags: boxNumberIsDragged == null || boxNumber == boxNumberIsDragged ? 1 : 0,
      child: _buildBox(color, offset),
      feedback: _buildBox(color, offset),
      childWhenDragging: _buildBox(color, offset, onlyBorder: true),
      onDragStarted: () {
        setState((){
          boxNumberIsDragged = boxNumber;
        });
      },
      onDragCompleted: () {
        setState((){
          boxNumberIsDragged = null;
        });
      },
      onDraggableCanceled: (_,__) {
        setState((){
          boxNumberIsDragged = null;
        });
      },
    );
  }

  Widget _buildBox(Color color, Offset offset, {bool onlyBorder: false}) {
    return new Container(
      height: 50.0,
      width: 50.0,
      margin: EdgeInsets.only(left: offset.dx, top: offset.dy),
      decoration: BoxDecoration(
          color: !onlyBorder ? color : Colors.grey,
          border: Border.all(color: color)),
    );
  }
}