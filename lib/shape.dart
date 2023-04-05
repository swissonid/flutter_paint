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
    print("Try do draw a shape with ${_points.length}points");
    //_localPaint(canvas);

    _paintTool.drawOn(canvas, _points);
  }

  void _localPaint(Canvas canvas) {
    final painter = Paint()
      ..color = const Color(0xFFFFDC00)
      ..strokeWidth = 2
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < _points.length - 1; i++) {
      canvas.drawLine(_points[i], _points[i + 1], painter);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Shape && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
