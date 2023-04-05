import 'package:flutter/material.dart';

const defaultPixelSize = Size(40, 40);

class SimpleCanvas extends StatelessWidget {
  final Size canvasSizeInSimplePixel;
  final Size simplePixelSize;
  const SimpleCanvas({
    Key? key,
    Size? canvasSizeInSimplePixel,
    Size? simplePixelSize,
  })  : canvasSizeInSimplePixel = canvasSizeInSimplePixel ?? const Size(10, 10),
        simplePixelSize = simplePixelSize ?? defaultPixelSize,
        super(key: key);

  Widget createLine(int columnIndex) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        canvasSizeInSimplePixel.width.toInt(),
        (rowIndex) => SimplePixel(
          offset: Offset(rowIndex.toDouble() + 1, columnIndex.toDouble() + 1),
          size: simplePixelSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          canvasSizeInSimplePixel.height.toInt(),
          (index) => createLine(index),
        ),
      ),
    );
  }
}

class SimplePixel extends StatelessWidget {
  final Offset offset;
  final Size size;
  const SimplePixel({Key? key, Size? size, required this.offset})
      : size = size ?? defaultPixelSize,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          "${offset.dx}x${offset.dy}",
          style: TextStyle(color: Colors.grey.shade300, fontSize: 8),
        ),
      ),
    );
  }
}
