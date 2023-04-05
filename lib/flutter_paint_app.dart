import 'package:fill_problem/simple_canvas.dart';
import 'package:flutter/material.dart';

import 'flutter_paint_canvas.dart';

class FlutterPaint extends StatefulWidget {
  const FlutterPaint({super.key});

  @override
  State<FlutterPaint> createState() => _FlutterPaintState();
}

class _FlutterPaintState extends State<FlutterPaint> {
  final _controller = FlutterPaintController();
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedItem,
          onTap: (index) {
            setState(() {
              _selectedItem = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.color_lens_outlined), label: 'Paint'),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_4x4_outlined),
              label: 'Simple Grid',
            ),
          ],
        ),
        backgroundColor: Colors.grey,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _selectedItem == 0
              ? _InterFlutterPaint(controller: _controller)
              : const SimpleCanvas(),
        ),
        floatingActionButton: _selectedItem == 0
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _controller.clear();
                  });
                },
                child: const Icon(Icons.delete),
              )
            : null,
      ),
    );
  }
}

class _InterFlutterPaint extends StatelessWidget {
  final FlutterPaintController controller;

  const _InterFlutterPaint({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Menu(
          selectedIndex: 0,
          menuItems: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.format_color_fill_outlined),
            )
          ],
        ),
        Expanded(
          child: FlutterPaintCanvas(
            controller: controller,
          ),
        ),
      ],
    );
  }
}

class Menu extends StatelessWidget {
  final int selectedIndex;
  final List<Widget> menuItems;
  const Menu({Key? key, required this.selectedIndex, required this.menuItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
      width: 56,
      child: Column(
        children: [...menuItems],
      ),
    );
  }
}
