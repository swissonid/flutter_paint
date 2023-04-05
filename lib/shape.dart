import 'package:fill_problem/paint_tools.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Shape {
  final List<Offset> _points;
  final PaintTool _paintTool;
  final String id;
  Shape({required List<Offset> points, required PaintTool paintTool})
      : _points = points,
        _paintTool = paintTool,
        id = const Uuid().v4().toString();

  drawOn(Canvas canvas) {
    _paintTool.drawOn(canvas, _points);
  }

  List<Offset> get points => [..._points];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Shape && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
