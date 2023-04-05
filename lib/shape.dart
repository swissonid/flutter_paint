import 'package:flutter/material.dart';

class Shape {
  final List<Offset> _points;
  final Paint _paint;
  Shape({required List<Offset> points, Paint? paint})
      : _points = [...points],
        _paint = paint ?? Paint()
          ..color = Colors.red
          ..strokeWidth = 4
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round;
  draw(Canvas canvas) {
    for (var i = 0; i < _points.length - 1; i++) {
      canvas.drawLine(_points[i], _points[i + 1], _paint);
    }
  }
}
