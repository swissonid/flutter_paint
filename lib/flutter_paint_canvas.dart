import 'package:fill_problem/shape.dart';
import 'package:flutter/material.dart';

final _canvasKey = GlobalKey();

class FlutterPaintController {
  final _shapes = <Shape>[];
  final _shapeUnderConstruction = <Offset>[];
  void onPanStart(Offset details) {
    _shapeUnderConstruction.add(details);
  }

  void onPanUpdate(Offset details) {
    _shapeUnderConstruction.add(details);
  }

  void onPanDown(Offset details) {
    _shapeUnderConstruction.add(details);
  }

  void onPanEnd() {
    _shapes.add(Shape(points: _shapeUnderConstruction));
    _shapeUnderConstruction.clear();
  }

  void clear() {
    _shapes.clear();
  }

  List<Shape> get shapes => _shapes;
}

class FlutterPaintCanvas extends StatefulWidget {
  final FlutterPaintController _controller;
  final Size _size;
  FlutterPaintCanvas({
    Key? key,
    Size? size,
    FlutterPaintController? controller,
  })  : _controller = controller ?? FlutterPaintController(),
        _size = size ?? const Size(500, 500),
        super(key: key);

  @override
  State<FlutterPaintCanvas> createState() => _FlutterPaintCanvasState();
}

class _FlutterPaintCanvasState extends State<FlutterPaintCanvas> {
  late final FlutterPaintController _controller;
  late final Offset _globalCanvasOffset;
  late final double _minDx, _maxDx;
  late final double _minDy, _maxDy;
  @override
  void initState() {
    _controller = widget._controller;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _calculateBoundary(context));
    super.initState();
  }

  void _calculateBoundary(BuildContext context) {
    final canvasRenderBox =
        _canvasKey.currentContext?.findRenderObject() as RenderBox;
    _globalCanvasOffset = canvasRenderBox.localToGlobal(Offset.zero);
    _minDx = _globalCanvasOffset.dx;
    _minDy = _globalCanvasOffset.dy;
    _maxDx = _minDx + widget._size.width;
    _maxDy = _minDy + widget._size.height;
  }

  bool _notAllowToPaint(Offset globalOffset) {
    final isInXRange = globalOffset.dx >= _minDx && globalOffset.dx <= _maxDx;
    final isInYRange = globalOffset.dy >= _minDy && globalOffset.dy <= _maxDy;
    final allowToPaint = isInXRange && isInYRange;
    return !allowToPaint;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanStart: (details) {
          if (_notAllowToPaint(details.globalPosition)) return;
          setState(() {
            _controller.onPanStart(details.localPosition);
          });
        },
        onPanUpdate: (details) {
          if (_notAllowToPaint(details.globalPosition)) return;
          setState(() {
            _controller.onPanUpdate(details.localPosition);
          });
        },
        onPanDown: (details) {
          if (_notAllowToPaint(details.globalPosition)) return;
          setState(() {
            _controller.onPanDown(details.localPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            _controller.onPanEnd();
          });
        },
        child: ColoredBox(
          color: Colors.white,
          child: CustomPaint(
            key: _canvasKey,
            size: widget._size,
            painter: MyPaint(
              shapeUnderConstruction: _controller._shapeUnderConstruction,
              shapes: _controller.shapes,
            ),
          ),
        ),
      ),
    );
  }
}

class MyPaint extends CustomPainter {
  final List<Shape> _shapes;
  final List<Offset> _shape;
  final _paint = Paint()
    ..color = Colors.red
    ..strokeWidth = 4
    ..isAntiAlias = true
    ..strokeCap = StrokeCap.round;
  MyPaint(
      {required List<Offset> shapeUnderConstruction,
      required List<Shape> shapes})
      : _shapes = shapes,
        _shape = shapeUnderConstruction,
        super();
  @override
  void paint(Canvas canvas, Size size) {
    _drawShape(canvas, _shape);
    for (var shape in _shapes) {
      shape.draw(canvas);
    }
  }

  void _drawShape(Canvas canvas, List<Offset> shape) {
    for (var i = 0; i < shape.length - 1; i++) {
      canvas.drawLine(shape[i], shape[i + 1], _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}