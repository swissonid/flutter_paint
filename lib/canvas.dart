import 'package:flutter/material.dart';

import 'flutter_paint_canvas.dart';

class FlutterPaint extends StatefulWidget {
  const FlutterPaint({super.key});

  @override
  State<FlutterPaint> createState() => _FlutterPaintState();
}

class _FlutterPaintState extends State<FlutterPaint> {
  final _controller = FlutterPaintController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Row(
        children: [
          const Menu(),
          Expanded(
            child: FlutterPaintCanvas(
              controller: _controller,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.clear();
          });
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
      width: 56,
      child: Column(
        children: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      ),
    );
  }
}
