import 'dart:ui';

abstract class CanvasTool {}

abstract class PaintTool extends CanvasTool {
  final Color color;
  PaintTool({required this.color});
  void drawOn(Canvas canvas, List<Offset> points);
  PaintTool copy();
}

class Pencil extends PaintTool {
  final int strokeThickness;
  late final Paint _painter;

  Pencil({Color? color, int? strokeThickness})
      : strokeThickness = strokeThickness ?? 2,
        super(color: color ?? const Color(0xFF000000)) {
    _painter = Paint()
      ..color = this.color
      ..strokeWidth = this.strokeThickness.toDouble()
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;
  }

  @override
  void drawOn(Canvas canvas, List<Offset> points) {
    for (var i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], _painter);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pencil &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          strokeThickness == other.strokeThickness;

  @override
  int get hashCode => color.hashCode ^ strokeThickness.hashCode;

  @override
  PaintTool copy() {
    return Pencil(color: color, strokeThickness: strokeThickness);
  }
}

class Eraser extends CanvasTool {}

//class ColorBucket extends PaintTool {}
